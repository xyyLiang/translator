    public func notifySchedulerListenersPausedTrigger( triggerKey: TriggerKey)  : Unit{
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                sl.triggerPaused(triggerKey);
            } catch (e:Exception) {
                log.error(  "Error while notifying SchedulerListener of paused trigger: ${triggerKey}" , e );
            }
        }
    }