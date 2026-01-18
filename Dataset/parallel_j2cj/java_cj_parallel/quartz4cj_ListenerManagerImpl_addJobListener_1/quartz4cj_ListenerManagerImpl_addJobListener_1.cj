    public func addJobListener(jobListener: JobListener , matcher: Matcher<JobKey> ) : Unit {
        if (jobListener.getName() == "") {
            throw IllegalArgumentException(   "JobListener name cannot be empty.");
        }
        
        synchronized (globalJobListenersLock) {
            globalJobListeners.put(jobListener.getName(), jobListener);
            let matchersL =  QzLinkedList<Matcher<JobKey>>();
            matchersL.append(matcher);
            globalJobListenersMatchers.put(jobListener.getName(), matchersL);
        }
    }