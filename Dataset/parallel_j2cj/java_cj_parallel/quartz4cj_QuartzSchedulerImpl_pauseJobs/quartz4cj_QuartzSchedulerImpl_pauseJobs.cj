    public func pauseJobs( groupMatcher0: ?GroupMatcher<JobKey>) : Unit  {
        validateState();

        let groupMatcher = groupMatcher0 ?? GroupMatcher<JobKey>.groupEquals(Scheduler.DEFAULT_GROUP)
        
        let pausedGroups = resources.getJobStore().pauseJobs(groupMatcher);
        notifySchedulerThread(0);
        for (pausedGroup in pausedGroups) {
            notifySchedulerListenersPausedJobs(pausedGroup);
        }
    }