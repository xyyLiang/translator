    public func resumeTrigger( triggerKey: TriggerKey) : Unit {
        validateState();

        resources.getJobStore().resumeTrigger(triggerKey);
        notifySchedulerThread(0);
        notifySchedulerListenersResumedTrigger(triggerKey);
    }