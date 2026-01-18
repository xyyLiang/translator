    public func releaseAcquiredTrigger( trigger: OperableTrigger) : Unit {
        synchronized (lock) {
            let twOpt = triggersByKey.get(trigger.getKey());
            let tw = twOpt ?? return ;
            if ( tw.state == TriggerWrapper.STATE_ACQUIRED) {
                tw.state = TriggerWrapper.STATE_WAITING;
                timeTriggers.put(tw);
            }
        }
    }