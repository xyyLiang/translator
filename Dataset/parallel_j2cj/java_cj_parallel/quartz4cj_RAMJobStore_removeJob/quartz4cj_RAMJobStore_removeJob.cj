    public func removeJob(jobKey: JobKey) : Bool {

        var found = false;

        synchronized (lock) {
            let triggersOfJob = getTriggersForJob(jobKey);
            for (trig in triggersOfJob) {
                this.removeTrigger(trig.getKey());
                found = true;
            }
            
            found = (jobsByKey.remove(jobKey).isPresent()) || found;
            if (found) {
                let grpMapOpt = jobsByGroup.get(jobKey.getGroup());
                if ( let Some(grpMap) <- grpMapOpt ) {
                    grpMap.remove(jobKey);
                    if (grpMap.size == 0) {
                        jobsByGroup.remove(jobKey.getGroup());
                    }
                }
            }
        }

        return found;
    }