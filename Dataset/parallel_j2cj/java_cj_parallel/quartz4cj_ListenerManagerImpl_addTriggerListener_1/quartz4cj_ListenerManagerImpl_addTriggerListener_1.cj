    public func addTriggerListener(triggerListener : TriggerListener , matcher : Matcher<TriggerKey> ): Unit {
        
        if (triggerListener.getName() == "") {
            throw IllegalArgumentException( "TriggerListener name cannot be empty.");
        }

        synchronized (globalTriggerListenersLock) {
            globalTriggerListeners.put(triggerListener.getName(), triggerListener);
            let matchers = QzLinkedList<Matcher<TriggerKey>>();
            matchers.append(matcher);
            globalTriggerListenersMatchers.put(triggerListener.getName(), matchers);
        }
    }