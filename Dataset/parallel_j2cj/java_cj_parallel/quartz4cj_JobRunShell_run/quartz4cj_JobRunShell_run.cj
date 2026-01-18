    public func run(): Unit   {
        qs.addInternalSchedulerListener(this)

        try {
            let trigger = jec.getTrigger();
            let jobDetail = jec.getJobDetail();

            do {

                var jobExEx : ?JobExecutionException = None;
                let job = jec.getJobInstance();

                try {
                    begin();
                } catch ( se:SchedulerException) {
                    qs.notifySchedulerListenersError("Error executing Job (${jec.getJobDetail().getKey()}): couldn't begin execution.", se);
                    break;
                }

                // notify job & trigger listeners...
                try {
                    if (!notifyListenersBeginning(jec)) {
                        break;
                    }
                } catch( ve: VetoedException) {
                    try {
                       let instCode = trigger.executionComplete(jec, None);
                       qs.notifyJobStoreJobVetoed(trigger, jobDetail, instCode);
                        
                        // QTZ-205
                        // Even if trigger got vetoed, we still needs to check to see if it's the trigger's finalized run or not.
                        if (!jec.getTrigger().getNextFireTime().isPresent()) {
                            qs.notifySchedulerListenersFinalized(jec.getTrigger());
                        }

                        complete(true);
                    } catch ( se: SchedulerException) {
                        qs.notifySchedulerListenersError("Error during veto of Job (${jec.getJobDetail().getKey()}): couldn't finalize execution.", se);
                    }
                    break;
                }

                let startTime = DateTime.currentTimeMillis()
                var endTime = startTime;

                // execute the job
                try {
                    if( log.isDebugEnabled()) {
                        log.debug("Calling execute on job ${jobDetail.getKey()}");
                    }
                    job.execute(jec);
                    endTime = DateTime.currentTimeMillis()
                } catch ( jee: JobExecutionException) {
                    endTime = DateTime.currentTimeMillis()
                    jobExEx = jee;
                    log.error("Job ${jobDetail.getKey()} threw a JobExecutionException:  " , jee);
                } catch (e: Exception) {
                    endTime = DateTime.currentTimeMillis()
                    log.error("Job ${jobDetail.getKey()} threw an unhandled Exception: ", e);
                    let se = SchedulerException(  "Job threw an unhandled exception.", e);
                    qs.notifySchedulerListenersError("Job ${jec.getJobDetail().getKey()} threw an exception.", se);
                    jobExEx = JobExecutionException(se, false);
                }

                jec.setJobRunTime(endTime - startTime);

                // notify all job listeners
                if (!notifyJobListenersComplete(jec, jobExEx)) {
                    break;
                }

                var instCode = CompletedExecutionInstruction.NOOP;

                // update the trigger
                try {
                    instCode = trigger.executionComplete(jec, jobExEx);
                } catch ( e: Exception) {
                    // If this happens, there's a bug in the trigger...
                    let se = SchedulerException("Trigger threw an unhandled exception.", e);
                    qs.notifySchedulerListenersError( "Please report this error to the Quartz developers.", se);
                }

                // notify all trigger listeners
                if (!notifyTriggerListenersComplete(jec, instCode)) {
                    break;
                }

                // update job/trigger or re-execute job
                if (instCode == CompletedExecutionInstruction.RE_EXECUTE_JOB) {
                    jec.incrementRefireCount();
                    try {
                        complete(false);
                    } catch ( se: SchedulerException) {
                        qs.notifySchedulerListenersError("Error executing Job (${jec.getJobDetail().getKey()}): couldn't finalize execution.", se);
                    }
                    continue;
                }

                try {
                    complete(true);
                } catch ( se: SchedulerException) {
                    qs.notifySchedulerListenersError("Error executing Job (${jec.getJobDetail().getKey()}): couldn't finalize execution.", se);
                    continue;
                }

                qs.notifyJobStoreJobComplete(trigger, jobDetail, instCode);
                break;
            } while (true);

        } finally {
           qs.removeInternalSchedulerListener(this);
        }
    }