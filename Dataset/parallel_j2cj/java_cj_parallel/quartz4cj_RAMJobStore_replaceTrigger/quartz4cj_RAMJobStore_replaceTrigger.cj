    public func replaceTrigger( triggerKey: TriggerKey,  newTrigger: OperableTrigger) : Bool {

        var found = false;

        synchronized (lock) {
            // remove from triggers by FQN map
            let twOpt = triggersByKey.remove(triggerKey);
            
            if (let Some(tw) <- twOpt ) {

                found = true

                if (  tw.getTrigger().getJobKey() != newTrigger.getJobKey()) {
                    throw JobPersistenceException("New trigger is not related to the same job as the old trigger.");
                }

                // remove from triggers by group
                let grpMapOPt = triggersByGroup.get(triggerKey.getGroup());
                if ( let Some(grpMap) <- grpMapOPt ) {
                    grpMap.remove(triggerKey);
                    if (grpMap.size == 0) {
                        triggersByGroup.remove(triggerKey.getGroup());
                    }
                }
                
                //remove from triggers by job
                let jobListOpt = triggersByJob.get(tw.jobKey);
                if( let Some(jobList) <- jobListOpt ) {
                    jobList.remove(tw);
                    if(jobList.isEmpty()) {
                        triggersByJob.remove(tw.jobKey);
                    }
                }
                
                timeTriggers.remove(tw);

                try {
                    storeTrigger(newTrigger, false);
                } catch(jpe: JobPersistenceException) {
                    storeTrigger(tw.getTrigger(), false); // put previous trigger back...
                    throw jpe;
                }
            }
        }

        return found;
    }
