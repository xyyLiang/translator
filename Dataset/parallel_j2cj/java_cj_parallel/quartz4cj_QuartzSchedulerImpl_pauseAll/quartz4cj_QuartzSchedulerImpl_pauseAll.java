    public void pauseAll() throws SchedulerException {
        validateState();

        resources.getJobStore().pauseAll();
        notifySchedulerThread(0L);
        notifySchedulerListenersPausedTriggers(null);
    }