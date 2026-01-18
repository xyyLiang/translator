    public func removeJobListener(name : String) : Bool{
        synchronized (globalJobListenersLock) {
            return (globalJobListeners.remove(name).isPresent());
        }
    }