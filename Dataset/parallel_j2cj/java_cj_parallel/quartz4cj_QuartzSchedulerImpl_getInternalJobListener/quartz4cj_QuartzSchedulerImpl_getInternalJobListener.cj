    public func  getInternalJobListener( name: String) : ?JobListener{
        synchronized (internalJobListenersLock) {
            return internalJobListeners.get(name);
        }
    }