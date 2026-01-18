    public func storeJobsAndTriggers(triggersAndJobs : Map<JobDetail, Set<OperableTrigger>> ,  replace: Bool )  :Unit {

        synchronized (lock) {
            // make sure there are no collisions...
            if(!replace) {
                for( (jobDetail,set) in triggersAndJobs ) {
                    if(checkExists(jobDetail.getKey())) {
                        throw ObjectAlreadyExistsException(jobDetail.getKey().toString());
                    }
                    for( trigger in set) {
                        if(checkExists(trigger.getKey())) {
                            throw ObjectAlreadyExistsException(trigger);
                        }
                    }
                }
            }

            // do bulk add...
            for( (jobDetail,set) in triggersAndJobs ) {
                storeJob(jobDetail, true);
                for( trigger in set) {
                    storeTrigger(trigger, true);
                }
            }
        }

    }