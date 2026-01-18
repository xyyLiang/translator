    public func pauseTrigger( triggerKey: TriggerKey) : Unit {

        synchronized (lock) {
            let twOpt = triggersByKey.get(triggerKey);
            let tw = twOpt ?? return ;

            // if the trigger is "complete" pausing it does not make sense...
            if (tw.state == TriggerWrapper.STATE_COMPLETE) {
                return;
            }

            if(tw.state == TriggerWrapper.STATE_BLOCKED) {
                tw.state = TriggerWrapper.STATE_PAUSED_BLOCKED;
            } else {
                tw.state = TriggerWrapper.STATE_PAUSED;
            }

            timeTriggers.remove(tw);
        }
    }