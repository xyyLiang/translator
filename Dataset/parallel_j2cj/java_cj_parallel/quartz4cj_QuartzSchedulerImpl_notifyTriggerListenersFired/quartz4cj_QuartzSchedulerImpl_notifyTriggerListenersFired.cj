    public func notifyTriggerListenersFired( jec: JobExecutionContext): Bool {

        var vetoedExecution = false;
        
        // build a list of all trigger listeners that are to be notified...
        let triggerListeners = buildTriggerListenerList();

        // notify all trigger listeners in the list
        for( tl in triggerListeners) {
            try {
                if(!matchTriggerListener(tl, jec.getTrigger().getKey())) {
                    continue;
                }
                tl.triggerFired(jec.getTrigger(), jec);
                
                if(tl.vetoJobExecution(jec.getTrigger(), jec)) {
                    vetoedExecution = true;
                }
            } catch (e:Exception) {
                let se = SchedulerException(  "TriggerListener '${tl.getName()}' threw exception: " + e.message)
                throw se;
            }
        }
        
        return vetoedExecution;
    }