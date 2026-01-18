    public func resetTriggerFromErrorState(triggerKey: TriggerKey) : Unit {

        synchronized (lock) {

            let twOpt = triggersByKey.get(triggerKey);

            if( let Some(tw) <- twOpt) {
                // is the trigger in error state?
                if (tw.state != TriggerWrapper.STATE_ERROR) {
                    return;
                }

                if(pausedTriggerGroups.contains(triggerKey.getGroup())) {
                    tw.state = TriggerWrapper.STATE_PAUSED;
                } else {
                    tw.state = TriggerWrapper.STATE_WAITING;
                    timeTriggers.put(tw);
                }
            }
            
         }
    }