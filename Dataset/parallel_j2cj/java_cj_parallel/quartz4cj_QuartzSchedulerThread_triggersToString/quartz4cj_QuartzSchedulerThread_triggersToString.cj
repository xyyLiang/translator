    public func run() : Unit {
        var acquiresFailed = 0;

        let jobStore = qsRsrcs.getJobStore(); 
        let threadPool = qsRsrcs.getThreadPool(); 
        let jobRunShellFactory = qsRsrcs.getJobRunShellFactory();

        while (!halted.load()) {
            try {
                // check if we're supposed to pause...
                synchronized (sigLock) {
                    while (paused && !halted.load()) {
                        // wait until togglePause(false) is called...
                        sigLock.wait(timeout: 1000*Duration.millisecond);

                        // reset failure counter when paused, so that we don't wait again after unpausing
                        acquiresFailed = 0;
                    }

                    if (halted.load()) {
                        break;
                    }
                }

                // wait a bit, if reading from job store is consistently failing (e.g. DB is down or restarting)..
                if (acquiresFailed > 1) {
                    try {
                        let delay = computeDelayForRepeatedErrors(jobStore, acquiresFailed);
                        sleep(delay*Duration.millisecond);
                    } catch ( ignore: Exception) {
                    }
                }

                let availThreadCount = threadPool.blockForAvailableThreads();
                synchronized (sigLock) {
                    if (halted.load()) {
                        break;
                    }
                }

                if(availThreadCount > 0) { // will always be true, due to semantics of blockForAvailableThreads...

                    var now = DateTime.currentTimeMillis()

                    clearSignaledSchedulingChange();

                    let  triggers : ArrayList<OperableTrigger>

                    try {
                        let minValue = min(availThreadCount, qsRsrcs.getMaxBatchSize())
                        triggers = jobStore.acquireNextTriggers( now + idleWaitTime, minValue, qsRsrcs.getBatchTimeWindow() );
                        acquiresFailed = 0;
                        if (minValue > 1 && log.isDebugEnabled()) {
                            log.debug("batch acquisition of " + triggers.size.toString() + " triggers");
                        }
                    } catch ( jpe: JobPersistenceException) {
                        if (acquiresFailed == 0) {
                            qs.notifySchedulerListenersError(  "An error occurred while scanning for the next triggers to fire.",  jpe);
                        }
                        if (acquiresFailed < Int64.MAX_VALUE) {
                            acquiresFailed++;
                        }
                        continue;
                    } catch ( e: Exception) {
                        if (acquiresFailed == 0) {
                             log.error("quartzSchedulerThreadLoop: Exception ${e.message}" , e);  
                        }
                        if (acquiresFailed < Int64.MAX_VALUE) {
                            acquiresFailed++;
                        }
                        continue;
                    }

                    if ( !triggers.isEmpty()) {

                        now = DateTime.currentTimeMillis() 
                        let triggerTime = triggers[0].getNextFireTime().getOrThrow().getTime()
                        var timeUntilTrigger = triggerTime - now;
                        while(timeUntilTrigger > 2) {
                            synchronized (sigLock) {
                                if (halted.load()) {
                                    break;
                                }
                                if (!isCandidateNewTimeEarlierWithinReason(triggerTime, false)) {
                                    // we could have blocked a long while on 'synchronize', so we must recompute
                                    now = DateTime.currentTimeMillis() 
                                    timeUntilTrigger = triggerTime - now;
                                    if(timeUntilTrigger >= 1) {
                                        sigLock.wait(timeout: timeUntilTrigger*Duration.millisecond);
                                    }
                                }
                            }
                            synchronized (sigLock) {
                                if (halted.load()) {
                                    break;
                                }
                            }
                            if(releaseIfScheduleChangedSignificantly(triggers, triggerTime)) {
                                break;
                            }
                            now = DateTime.currentTimeMillis() 
                            timeUntilTrigger = triggerTime - now;
                        }

                        // this happens if releaseIfScheduleChangedSignificantly decided to release triggers
                        if(triggers.isEmpty()) {
                            continue;
                        }

                        // set triggers to 'executing'
                        var bndles = ArrayList<TriggerFiredResult>();

                        var goAhead = true;
                        synchronized(sigLock) {
                            goAhead = !halted.load();
                        }

                        if(goAhead) {
                            try {
                                bndles = jobStore.triggersFired(triggers);
                              } catch ( se: SchedulerException) {
                                qs.notifySchedulerListenersError( "An error occurred while firing triggers ${triggersToString(triggers)}" , se);
                                //QTZ-179 : a problem occurred interacting with the triggers from the db; we release them and loop again
                                for ( i in 0 .. triggers.size ) {
                                    jobStore.releaseAcquiredTrigger(triggers[i]);
                                }
                                continue;
                            }
                        }

                        for ( i in 0 .. bndles.size ) {
                            let result : TriggerFiredResult =  bndles[i];
                            let currentTrigger = result.getTrigger()  // quartz 原有代码这里有 bug, 返回的bndles长度和原始的triggers长度不一定相同，可能导致异常, 已修复

                            let bndleOpt : ?TriggerFiredBundle=  result.getTriggerFiredBundle();
                            let exceptionOpt : ?Exception = result.getException();

                            if ( let Some(exception) <- exceptionOpt ) {
                                log.error("Exception while firing trigger ${currentTrigger.getKey()}" , exception );
                                jobStore.releaseAcquiredTrigger(currentTrigger); 
                                continue;
                            }

                            // it's possible to get 'null' if the triggers was paused,
                            // blocked, or other similar occurrences that prevent it being
                            // fired at this time...  or if the scheduler was shutdown (halted)
                            if (!bndleOpt.isPresent()) {
                                jobStore.releaseAcquiredTrigger(currentTrigger);
                                continue;
                            }

                            let bndle = bndleOpt.getOrThrow()

                            try {
                                let shell = jobRunShellFactory.createJobRunShell(bndle,qs);

                                if ( !threadPool.runInThread({ => shell.run() }) ) {
                                    // this case should never happen, as it is indicative of the
                                    // scheduler being shutdown or a bug in the thread pool or
                                    // a thread pool being used concurrently - which the docs
                                    // say not to do...
                                    log.error("ThreadPool.runInThread() return false!");
                                    jobStore.triggeredJobComplete(currentTrigger, bndle.getJobDetail(), CompletedExecutionInstruction.SET_ALL_JOB_TRIGGERS_ERROR);
                                }
                                
                            } catch (se: SchedulerException) {
                                jobStore.triggeredJobComplete(currentTrigger, bndle.getJobDetail(), CompletedExecutionInstruction.SET_ALL_JOB_TRIGGERS_ERROR);
                                continue;
                            }

                        }

                        continue; // while (!halted)
                    }
                } else { // if(availThreadCount > 0)
                    // should never happen, if threadPool.blockForAvailableThreads() follows contract
                    continue; // while (!halted)
                }

                let now = DateTime.currentTimeMillis() 
                let waitTime = now + getRandomizedIdleWaitTime();
                let timeUntilContinue = waitTime - now;
                synchronized(sigLock) {
                    if(!halted.load()) {
                        // QTZ-336 A job might have been completed in the mean time and we might have
                        // missed the scheduled changed signal by not waiting for the notify() yet
                        // Check that before waiting for too long in case this very job needs to be
                        // scheduled very soon
                        if (!isScheduleChanged()) {
                          sigLock.wait(timeout: timeUntilContinue*Duration.millisecond);
                        }
                    }
                }

            } catch(re: Exception) {
                log.error("Runtime error occurred in main trigger firing loop.", re );
            }
        }  
    }