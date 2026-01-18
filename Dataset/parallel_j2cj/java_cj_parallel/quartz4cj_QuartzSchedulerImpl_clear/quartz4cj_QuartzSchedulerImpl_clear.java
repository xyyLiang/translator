    public void clear() throws SchedulerException {
        validateState();

        resources.getJobStore().clearAllSchedulingData();
        notifySchedulerListenersUnscheduled(null);
    }