    public BroadcastJobListener(String name, List<JobListener> listeners) {
        this(name);
        this.listeners.addAll(listeners);
    }