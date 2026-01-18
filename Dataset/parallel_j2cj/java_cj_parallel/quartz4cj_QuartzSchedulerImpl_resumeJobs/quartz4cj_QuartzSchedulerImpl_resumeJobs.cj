    public func resumeJobs(matcher0: ?GroupMatcher<JobKey> ) : Unit {
        validateState();

        let matcher = matcher0 ?? GroupMatcher<JobKey>.groupEquals(Scheduler.DEFAULT_GROUP)
        
        let resumedGroups = resources.getJobStore().resumeJobs(matcher);
        notifySchedulerThread(0);
        for (pausedGroup in resumedGroups) {
            notifySchedulerListenersResumedJobs(pausedGroup);
        }
    }