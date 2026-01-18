    public JobListener getInternalJobListener(String name) {
        synchronized (internalJobListeners) {
            return internalJobListeners.get(name);
        }
    }