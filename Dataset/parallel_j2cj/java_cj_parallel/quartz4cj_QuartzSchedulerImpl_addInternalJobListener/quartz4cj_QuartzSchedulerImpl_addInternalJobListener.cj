    public func addInternalJobListener( jobListener: JobListener) : Unit  {
        if (jobListener.getName() == "") {
            throw IllegalArgumentException( "JobListener name cannot be empty.");
        }
        
        synchronized (internalJobListenersLock) {
            internalJobListeners.put(jobListener.getName(), jobListener);
        }
    }