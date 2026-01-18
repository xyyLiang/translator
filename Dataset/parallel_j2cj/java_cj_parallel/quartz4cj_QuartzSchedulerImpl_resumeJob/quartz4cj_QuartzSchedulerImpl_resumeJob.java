    public void resumeJob(JobKey jobKey) throws SchedulerException {
        validateState();

        resources.getJobStore().resumeJob(jobKey);
        notifySchedulerThread(0L);
        notifySchedulerListenersResumedJob(jobKey);
    }