    public func addTriggerListener(triggerListener : TriggerListener , matchers: Collection<Matcher<TriggerKey>>) : Unit{
        if (triggerListener.getName() ==  "") {
            throw IllegalArgumentException(     "TriggerListener name cannot be empty.");
        }

        synchronized (globalTriggerListenersLock) {
            globalTriggerListeners.put(triggerListener.getName(), triggerListener);

            let matchersL = QzLinkedList<Matcher<TriggerKey>>();
            if(matchers.size > 0) {
                matchersL.appendAll(matchers);
            } else {
                matchersL.append(EverythingMatcher<TriggerKey>.all());
            }

            globalTriggerListenersMatchers.put(triggerListener.getName(), matchersL);
        }
    }