    public func notifySchedulerListenersShuttingdown()  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.schedulerShuttingdown();
            } catch ( e: Exception) { 
                log.error("Error while notifying SchedulerListener of shutdown." , e);
            }
        }
    }