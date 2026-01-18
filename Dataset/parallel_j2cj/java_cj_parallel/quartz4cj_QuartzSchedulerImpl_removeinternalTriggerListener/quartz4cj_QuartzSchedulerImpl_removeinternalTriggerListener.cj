    public func removeinternalTriggerListener( name: String) : Bool {
        synchronized (internalTriggerListenersLock) {
            return (internalTriggerListeners.remove(name).isPresent());
        }
    }