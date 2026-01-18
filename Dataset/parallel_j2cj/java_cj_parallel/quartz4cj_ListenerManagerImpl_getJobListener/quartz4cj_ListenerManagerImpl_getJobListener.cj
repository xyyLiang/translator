    public func getJobListener(name : String): ?JobListener {
        synchronized (globalJobListenersLock) {
            return globalJobListeners.get(name);
        }
    }