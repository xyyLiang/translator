    public boolean removeinternalTriggerListener(String name) {
        synchronized (internalTriggerListeners) {
            return (internalTriggerListeners.remove(name) != null);
        }
    }