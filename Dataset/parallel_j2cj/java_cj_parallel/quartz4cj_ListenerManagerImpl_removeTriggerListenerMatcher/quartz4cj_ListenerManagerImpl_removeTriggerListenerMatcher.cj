    public func removeTriggerListenerMatcher(listenerName: String , matcher : Matcher<TriggerKey> )  : Bool{
        synchronized (globalTriggerListenersLock) {
            let matchersOpt = globalTriggerListenersMatchers.get(listenerName);
            let matchers =  matchersOpt ?? return false;  
            return matchers.remove(matcher);
        }
    }