    public func deleteJobs( jobKeys: Collection<JobKey>)  : Bool  {
        validateState();
        
        // deleteJob 里调用了 unscheduleJob ，deleteJobs 没有调用, 逻辑不一致，不做修改
        let result = resources.getJobStore().removeJobs(jobKeys);
        notifySchedulerThread(0);
        for(key in jobKeys) {
            notifySchedulerListenersJobDeleted(key);
        }
        return result;
    }