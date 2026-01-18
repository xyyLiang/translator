    public func deleteJob( jobKey: JobKey)  : Bool  {
        validateState();

        var result = false;
        
        let triggers = getTriggersOfJob(jobKey);
        for (trigger in triggers) {
            if (!unscheduleJob(trigger.getKey())) {
                let msg = "Unable to unschedule trigger [${trigger.getKey()}] while deleting job [${jobKey}]";
                throw SchedulerException(msg);
            }
            result = true;
        }

        result = resources.getJobStore().removeJob(jobKey) || result;
        if (result) {
            notifySchedulerThread(0);
            notifySchedulerListenersJobDeleted(jobKey);
        }
        return result;
    }