    public func removeInternalJobListener( name: String) : Bool {
        synchronized (internalJobListenersLock) {
            return (internalJobListeners.remove(name).isPresent());
        }
    }