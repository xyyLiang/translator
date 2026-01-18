    public func addJobListenerMatcher(listenerName: String , matcher: Matcher<JobKey> ) : Bool{
        synchronized (globalJobListenersLock) {
            let matchersOpt = globalJobListenersMatchers.get(listenerName);
            let matchers =  matchersOpt ?? return false;  
            matchers.append(matcher);
            return true;
        }
    }