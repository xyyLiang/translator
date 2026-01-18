    public func addTriggerListenerMatcher(listenerName: String , matcher : Matcher<TriggerKey> ): Bool {
        synchronized (globalTriggerListenersLock) {
            let matchersOpt =  globalTriggerListenersMatchers.get(listenerName);
            let matchers =  matchersOpt ?? return false; 
            matchers.append(matcher);
            return true;
        }
    }