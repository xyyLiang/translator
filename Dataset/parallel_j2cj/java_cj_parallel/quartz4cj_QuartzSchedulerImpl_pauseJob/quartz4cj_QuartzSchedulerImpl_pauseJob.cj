    public func pauseJob( jobKey: JobKey) : Unit {
        validateState();

        resources.getJobStore().pauseJob(jobKey);
        notifySchedulerThread(0);
        notifySchedulerListenersPausedJob(jobKey);
    }