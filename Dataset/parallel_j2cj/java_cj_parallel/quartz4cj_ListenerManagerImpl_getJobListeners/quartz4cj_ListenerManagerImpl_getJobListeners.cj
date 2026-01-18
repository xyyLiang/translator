    public func getJobListeners() : Collection<JobListener>{
        synchronized (globalJobListenersLock) {
            return globalJobListeners.values()
        }
    }