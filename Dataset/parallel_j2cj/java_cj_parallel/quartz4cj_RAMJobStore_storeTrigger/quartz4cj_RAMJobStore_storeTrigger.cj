    public func storeTrigger(newTrigger: OperableTrigger, replaceExisting: Bool) :Unit {
        let tw = TriggerWrapper(newTrigger.clone());
        synchronized (lock) {
            if (triggersByKey.contains(tw.key) ) {
                if (!replaceExisting) {
                    throw ObjectAlreadyExistsException(newTrigger);
                }
                removeTrigger(newTrigger.getKey(), false);
            }
    
            if ( !retrieveJob(newTrigger.getJobKey()).isPresent()) {
                throw JobPersistenceException("The job (${newTrigger.getJobKey()}) referenced by the trigger does not exist.");
            }

            // add to triggers by job
            let jobListOpt = triggersByJob.get(tw.jobKey);
            match( jobListOpt ) {
                case Some(jobList) =>
                    jobList.append(tw);
                case None =>
                    let jobList = QzLinkedList<TriggerWrapper>();
                    triggersByJob.put(tw.jobKey, jobList);
                    jobList.append(tw);
            }
            
            // add to triggers by group
            let grpMapOpt = triggersByGroup.get(newTrigger.getKey().getGroup());
            match( grpMapOpt ) {
                case Some(grpMap) =>
                     grpMap.put(newTrigger.getKey(), tw);
                case None =>
                    let grpMap = HashMap<TriggerKey, TriggerWrapper>(100);
                    triggersByGroup.put(newTrigger.getKey().getGroup(), grpMap);
                    grpMap.put(newTrigger.getKey(), tw);
            }

            // add to triggers by FQN map
            triggersByKey.put(tw.key, tw);

            if (pausedTriggerGroups.contains(newTrigger.getKey().getGroup())  || 
                    pausedJobGroups.contains(newTrigger.getJobKey().getGroup())) {
                tw.state = TriggerWrapper.STATE_PAUSED;
                if (blockedJobs.contains(tw.jobKey)) {
                    tw.state = TriggerWrapper.STATE_PAUSED_BLOCKED;
                }
            } else if (blockedJobs.contains(tw.jobKey)) {
                tw.state = TriggerWrapper.STATE_BLOCKED;
            } else {
                timeTriggers.put(tw);
            }
        }
    }