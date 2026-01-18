    public func notifySchedulerListenersScheduled( trigger: Trigger)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for( sl in schedListeners) {
            try {
                sl.jobScheduled(trigger);
            } catch (e:Exception) {
                log.error(  "Error while notifying SchedulerListener of scheduled job.  Triger=${trigger.getKey()}" , e );
            }
        }
    }