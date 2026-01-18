    public func getJobListenerMatchers(listenerName: String ) : ?Collection<Matcher<JobKey>>  {
        synchronized (globalJobListenersLock) {
            let matchersOpt =  globalJobListenersMatchers.get(listenerName);
            match( matchersOpt ) {
                case Some(matchers) => matchers
                case None => None 
            }
        }
    }