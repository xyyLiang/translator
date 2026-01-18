    public void pauseTrigger(TriggerKey triggerKey) throws SchedulerException {
        validateState();

        resources.getJobStore().pauseTrigger(triggerKey);
        notifySchedulerThread(0L);
        notifySchedulerListenersPausedTrigger(triggerKey);
    }