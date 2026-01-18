    public func notifyTriggerListenersMisfired( trigger: Trigger) : Unit {
        // build a list of all trigger listeners that are to be notified...
        let  triggerListeners = buildTriggerListenerList();

        // notify all trigger listeners in the list
        for(tl in triggerListeners) {
            try {
                if(!matchTriggerListener(tl, trigger.getKey())) {
                    continue;
                }
                tl.triggerMisfired(trigger);
            } catch (e:Exception) {
                let se = SchedulerException(  "TriggerListener '${tl.getName()}' threw exception: " + e.message )
                throw se;
            }
        }
    }    