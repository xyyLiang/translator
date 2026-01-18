    public List<JobListener> getInternalJobListeners() {
        synchronized (internalJobListeners) {
            return java.util.Collections.unmodifiableList(new LinkedList<JobListener>(internalJobListeners.values()));
        }
    }