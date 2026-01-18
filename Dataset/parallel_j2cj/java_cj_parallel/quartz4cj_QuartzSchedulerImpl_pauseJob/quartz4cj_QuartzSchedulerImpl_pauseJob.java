    public void pauseJob(JobKey jobKey) throws SchedulerException {
        validateState();

        resources.getJobStore().pauseJob(jobKey);
        notifySchedulerThread(0L);
        notifySchedulerListenersPausedJob(jobKey);
    }