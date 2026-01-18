    public func addInternalTriggerListener( triggerListener: TriggerListener) : Unit {
        if (triggerListener.getName() == "" ) {
            throw IllegalArgumentException( "TriggerListener name cannot be empty.");
        }

        synchronized (internalTriggerListenersLock) {
            internalTriggerListeners.put(triggerListener.getName(), triggerListener);
        }
    }