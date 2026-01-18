    public func resumeJob( jobKey: JobKey) : Unit {

        synchronized (lock) {
            let triggersOfJob = getTriggersForJob(jobKey);
            for (trigger in triggersOfJob) {
                resumeTrigger(trigger.getKey());
            }
        }
    }