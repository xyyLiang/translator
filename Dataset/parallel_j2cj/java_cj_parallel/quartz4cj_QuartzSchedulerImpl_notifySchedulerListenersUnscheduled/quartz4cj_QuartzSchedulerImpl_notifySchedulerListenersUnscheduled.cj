    public func notifySchedulerListenersUnscheduled( triggerKey: TriggerKey)  : Unit {
        // build a list of all scheduler listeners that are to be notified...
        let schedListeners = buildSchedulerListenerList();

        // notify all scheduler listeners
        for(sl in schedListeners) {
            try {
                if(triggerKey == TriggerKey.EMPTY_KEY) {
                    sl.schedulingDataCleared();
                } else {
                    sl.jobUnscheduled(triggerKey);
                }
            } catch (e:Exception) {
                let s = if(triggerKey == TriggerKey.EMPTY_KEY) { "ALL DATA" } else { triggerKey.toString() }
                log.error(  "Error while notifying SchedulerListener of unscheduled job.  Triger=${s}" , e );
            }
        }
    }