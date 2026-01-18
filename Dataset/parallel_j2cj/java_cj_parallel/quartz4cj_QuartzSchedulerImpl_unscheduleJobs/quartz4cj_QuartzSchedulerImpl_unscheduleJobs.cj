    public func unscheduleJobs(triggerKeys: Collection<TriggerKey> ) : Bool {
        validateState();

        let result = resources.getJobStore().removeTriggers(triggerKeys);
        notifySchedulerThread(0);
        for(key in  triggerKeys) {
            notifySchedulerListenersUnscheduled(key);
        }
        return result;
    }