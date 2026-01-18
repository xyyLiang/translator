    public func resumeTriggers( matcher0: ?GroupMatcher<TriggerKey>) : Unit {
        validateState();

        let matcher = matcher0 ?? GroupMatcher<TriggerKey>.groupEquals(Scheduler.DEFAULT_GROUP)

        let pausedGroups = resources.getJobStore().resumeTriggers(matcher);
        notifySchedulerThread(0);
        for (pausedGroup in pausedGroups) {
            notifySchedulerListenersResumedTriggers(pausedGroup);
        }
    }