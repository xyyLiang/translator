    public void resumeTrigger(TriggerKey triggerKey) throws SchedulerException {
        validateState();

        resources.getJobStore().resumeTrigger(triggerKey);
        notifySchedulerThread(0L);
        notifySchedulerListenersResumedTrigger(triggerKey);
    }