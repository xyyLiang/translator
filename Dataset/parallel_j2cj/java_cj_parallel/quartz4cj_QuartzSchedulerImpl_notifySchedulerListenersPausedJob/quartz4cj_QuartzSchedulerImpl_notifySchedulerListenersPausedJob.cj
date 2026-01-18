    public func notifySchedulerListenersPausedJob( key: JobKey)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.jobPaused(key);
            } catch ( e :Exception) {
                log.error(  "Error while notifying SchedulerListener of paused job: ${key}" , e );
            }
        }
    }