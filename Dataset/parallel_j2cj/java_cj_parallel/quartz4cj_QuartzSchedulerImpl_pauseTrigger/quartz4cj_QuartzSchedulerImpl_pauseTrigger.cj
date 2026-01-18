    public func pauseTrigger( triggerKey: TriggerKey) : Unit {
        validateState();

        resources.getJobStore().pauseTrigger(triggerKey);
        notifySchedulerThread(0);
        notifySchedulerListenersPausedTrigger(triggerKey);
    }