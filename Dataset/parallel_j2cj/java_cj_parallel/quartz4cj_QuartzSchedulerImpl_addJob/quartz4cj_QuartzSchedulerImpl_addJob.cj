    public func addJob( jobDetail: JobDetail, replace: Bool, storeNonDurableWhileAwaitingScheduling: Bool ) : Unit  {
        validateJobKey(jobDetail.getKey())
        validateState();

        if (!storeNonDurableWhileAwaitingScheduling && !jobDetail.isDurable()) {
            throw SchedulerException( "Jobs added with no trigger must be durable.");
        }

        resources.getJobStore().storeJob(jobDetail, replace);
        notifySchedulerThread(0);
        notifySchedulerListenersJobAdded(jobDetail);
    }