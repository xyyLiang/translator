    public func addJobListener(jobListener: JobListener , matchers : Collection<Matcher<JobKey>> ): Unit {
        if (jobListener.getName() == "" ) {
            throw IllegalArgumentException( "JobListener name cannot be empty.");
        }
        
        synchronized (globalJobListenersLock) {
            globalJobListeners.put(jobListener.getName(), jobListener);
            let matchersL =  QzLinkedList<Matcher<JobKey>>();
            if(matchers.size > 0) {
                matchersL.appendAll(matchers);
            } else {
                matchersL.append(EverythingMatcher<JobKey>.all());
            }

            globalJobListenersMatchers.put(jobListener.getName(), matchersL);
        }
    }