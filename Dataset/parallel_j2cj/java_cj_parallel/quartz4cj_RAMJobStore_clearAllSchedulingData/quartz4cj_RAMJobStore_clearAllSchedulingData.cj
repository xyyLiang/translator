    public func clearAllSchedulingData() : Unit {

        synchronized (lock) {
            // unschedule jobs (delete triggers)
            let lst1 = getTriggerGroupNames();
            for (group in lst1) {
                let keys = getTriggerKeys(GroupMatcher<TriggerKey>.groupEquals(group));
                for (key in keys) {
                    removeTrigger(key);
                }
            }
            // delete jobs
            let lst2 = getJobGroupNames();
            for (group in lst2) {
                let keys = getJobKeys(GroupMatcher<JobKey>.groupEquals(group));
                for (key in keys) {
                    removeJob(key);
                }
            }
            // delete calendars
            let lst3 = getCalendarNames();
            for(name in lst3) {
                removeCalendar(name);
            }
        }
    }