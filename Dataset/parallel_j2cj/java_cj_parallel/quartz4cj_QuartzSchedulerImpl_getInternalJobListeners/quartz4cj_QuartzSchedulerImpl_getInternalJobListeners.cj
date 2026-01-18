    func getInternalJobListeners() : ArrayList<JobListener>{
        synchronized (internalJobListenersLock) {
            return ArrayList<JobListener>(internalJobListeners.values())
        }
    }