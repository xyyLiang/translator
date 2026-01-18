    public func setJobListenerMatchers(listenerName: String , matchers : Collection<Matcher<JobKey>> ) : Bool {
        synchronized (globalJobListenersLock) {
            let oldMatchersOpt = globalJobListenersMatchers.get(listenerName);
            if(!oldMatchersOpt.isPresent()) {
                return false;
            }
            globalJobListenersMatchers.put(listenerName, QzLinkedList(matchers));
            return true;
        }
    }