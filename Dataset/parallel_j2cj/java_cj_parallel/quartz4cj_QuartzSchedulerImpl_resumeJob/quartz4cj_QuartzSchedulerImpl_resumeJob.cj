    public func resumeJob( jobKey: JobKey) : Unit {
        validateState();

        resources.getJobStore().resumeJob(jobKey);
        notifySchedulerThread(0);
        notifySchedulerListenersResumedJob(jobKey);
    }