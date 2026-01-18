    public func removeJobListenerMatcher(listenerName: String , matcher: Matcher<JobKey> ) : Bool {
        synchronized (globalJobListenersLock) {
            let matchersOpt = globalJobListenersMatchers.get(listenerName);
            let matchers =  matchersOpt ?? return false;  
            return matchers.remove(matcher);
        }
    }