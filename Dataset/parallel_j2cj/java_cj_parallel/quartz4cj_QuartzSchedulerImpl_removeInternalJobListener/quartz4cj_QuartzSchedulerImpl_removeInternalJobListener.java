    public boolean removeInternalJobListener(String name) {
        synchronized (internalJobListeners) {
            return (internalJobListeners.remove(name) != null);
        }
    }