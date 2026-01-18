    public func triggeredJobComplete( trigger: OperableTrigger,  jobDetail: JobDetail,  triggerInstCode: CompletedExecutionInstruction) : Unit {

        synchronized (lock) {

            let jwOpt = jobsByKey.get(jobDetail.getKey());
            let twOpt = triggersByKey.get(trigger.getKey());

            // It's possible that the job is null if:
            //   1- it was deleted during execution
            //   2- RAMJobStore is being used only for volatile jobs / triggers from the JDBC job store
            if ( let Some(jw) <- jwOpt ) {
                var jd = jw.jobDetail;

                if (jd.isPersistJobDataAfterExecution()) {
                    let newData0 = jobDetail.getJobDataMap();
                    let newData = newData0.copy(); // 原来是clone
                    newData.clearDirtyFlag();
                    jd = jd.getJobBuilder().setJobData(newData).build();
                    jw.jobDetail = jd;
                }
                if (jd.isConcurrentExectionDisallowed()) {
                    blockedJobs.remove(jd.getKey());
                    let trigs = getTriggerWrappersForJob(jd.getKey());
                    for(ttw in trigs) {
                        if (ttw.state == TriggerWrapper.STATE_BLOCKED) {
                            ttw.state = TriggerWrapper.STATE_WAITING;
                            timeTriggers.put(ttw);
                        }
                        if (ttw.state == TriggerWrapper.STATE_PAUSED_BLOCKED) {
                            ttw.state = TriggerWrapper.STATE_PAUSED;
                        }
                    }
                    getSignaler().signalSchedulingChange(0);
                }
            } else { // even if it was deleted, there may be cleanup to do
                blockedJobs.remove(jobDetail.getKey());
            }
    
            // check for trigger deleted during execution...
            if (  let Some(tw) <- twOpt  ) {
                if (triggerInstCode == CompletedExecutionInstruction.DELETE_TRIGGER) {
                    
                    if(!trigger.getNextFireTime().isPresent()) {
                        // double check for possible reschedule within job 
                        // execution, which would cancel the need to delete...
                        if(!tw.getTrigger().getNextFireTime().isPresent()) {
                            removeTrigger(trigger.getKey());
                        }
                    } else {
                        removeTrigger(trigger.getKey());
                        getSignaler().signalSchedulingChange(0);
                    }
                } else if (triggerInstCode == CompletedExecutionInstruction.SET_TRIGGER_COMPLETE) {
                    tw.state = TriggerWrapper.STATE_COMPLETE;
                    timeTriggers.remove(tw);
                    getSignaler().signalSchedulingChange(0);
                } else if(triggerInstCode == CompletedExecutionInstruction.SET_TRIGGER_ERROR) {
                    log.info("Trigger ${trigger.getKey()} set to ERROR state.");
                    tw.state = TriggerWrapper.STATE_ERROR;
                    getSignaler().signalSchedulingChange(0);
                } else if (triggerInstCode == CompletedExecutionInstruction.SET_ALL_JOB_TRIGGERS_ERROR) {
                    log.info("All triggers of Job  ${trigger.getJobKey()} set to ERROR state.");
                    setAllTriggersOfJobToState(trigger.getJobKey(), TriggerWrapper.STATE_ERROR);
                    getSignaler().signalSchedulingChange(0);
                } else if (triggerInstCode == CompletedExecutionInstruction.SET_ALL_JOB_TRIGGERS_COMPLETE) {
                    setAllTriggersOfJobToState(trigger.getJobKey(), TriggerWrapper.STATE_COMPLETE);
                    getSignaler().signalSchedulingChange(0);
                }
            }
        }
    }