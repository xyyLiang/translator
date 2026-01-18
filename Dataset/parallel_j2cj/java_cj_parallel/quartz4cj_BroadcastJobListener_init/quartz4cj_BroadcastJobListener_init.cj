    public init( name: String, ls: Collection<JobListener> ) {
        this(name);
        this.listeners.appendAll(ls);
    }