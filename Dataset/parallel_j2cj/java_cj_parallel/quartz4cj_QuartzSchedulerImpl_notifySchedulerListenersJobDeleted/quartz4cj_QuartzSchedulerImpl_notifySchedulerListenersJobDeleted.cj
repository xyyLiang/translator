    public func notifySchedulerListenersJobDeleted( jobKey: JobKey)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.jobDeleted(jobKey);
            } catch ( e: Exception) {
                log.error(  "Error while notifying SchedulerListener of JobAdded.",e );
            }
        }
    }