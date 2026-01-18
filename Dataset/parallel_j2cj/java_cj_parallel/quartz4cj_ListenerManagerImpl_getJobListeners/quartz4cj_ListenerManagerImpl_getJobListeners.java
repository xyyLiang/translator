    public List<JobListener> getJobListeners() {
        synchronized (globalJobListeners) {
            return java.util.Collections.unmodifiableList(new LinkedList<JobListener>(globalJobListeners.values()));
        }
    }
