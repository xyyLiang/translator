    func removeTrigger(key: TriggerKey, removeOrphanedJob: Bool ) : Bool {

        var found = false

        synchronized (lock) {
            // remove from triggers by FQN map
            let twOption = triggersByKey.remove(key);
            if (let Some(tw) <- twOption ) {
                found = true
                // remove from triggers by group
                let grpMapOption = triggersByGroup.get(key.getGroup());
                if (let Some(grpMap) <- grpMapOption ) {
                    grpMap.remove(key);
                    if (grpMap.size == 0) {
                        triggersByGroup.remove(key.getGroup());
                    }
                }

                //remove from triggers by job
                let jobListOption = triggersByJob.get(tw.jobKey);
                if( let Some(jobList) <- jobListOption ) {
                    jobList.remove(tw);
                    if(jobList.isEmpty()) {
                        triggersByJob.remove(tw.jobKey);
                    }
                }
               
                timeTriggers.remove(tw);

                if (removeOrphanedJob) {
                    let jwOpt = jobsByKey.get(tw.jobKey);
                    if( let Some(jw) <- jwOpt ) {
                        let trigs : Collection<OperableTrigger> = getTriggersForJob(tw.jobKey);

                        if (  trigs.size == 0 && !jw.jobDetail.isDurable()) {
                            if (removeJob(jw.key)) {
                               getSignaler().notifySchedulerListenersJobDeleted(jw.key);
                            }
                        }
                    }
                }
            }
        }

        return found;
    }
