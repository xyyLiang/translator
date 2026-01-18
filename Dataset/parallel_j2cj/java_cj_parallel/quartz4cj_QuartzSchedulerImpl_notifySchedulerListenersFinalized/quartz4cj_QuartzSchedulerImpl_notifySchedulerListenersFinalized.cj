    public func notifySchedulerListenersFinalized( trigger: Trigger)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.triggerFinalized(trigger);
            } catch (e:Exception) {
                log.error( "Error while notifying SchedulerListener of finalized trigger.  Triger= ${trigger.getKey()}" , e);
            }
        }
    }