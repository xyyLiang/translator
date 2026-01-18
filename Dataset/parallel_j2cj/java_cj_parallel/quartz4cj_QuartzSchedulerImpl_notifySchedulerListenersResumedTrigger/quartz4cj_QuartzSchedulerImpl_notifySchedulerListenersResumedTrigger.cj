    public func notifySchedulerListenersResumedTrigger( key: TriggerKey)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.triggerResumed(key);
            } catch (e:Exception) {
                log.error( "Error while notifying SchedulerListener of resumed trigger: ${key}" , e );
            }
        }
    }