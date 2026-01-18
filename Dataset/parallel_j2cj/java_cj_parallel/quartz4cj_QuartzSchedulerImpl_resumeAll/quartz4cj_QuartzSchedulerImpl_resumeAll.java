    public void resumeAll() throws SchedulerException {
        validateState();

        resources.getJobStore().resumeAll();
        notifySchedulerThread(0L);
        notifySchedulerListenersResumedTrigger(null);
    }