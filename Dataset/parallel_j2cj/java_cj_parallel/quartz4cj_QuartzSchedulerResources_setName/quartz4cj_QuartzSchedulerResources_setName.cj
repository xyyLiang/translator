    public func setName( name: String) : Unit {
        if (name == "") {
            throw IllegalArgumentException(  "Scheduler name cannot be empty.");
        }

        this.name = name;
        
        if (threadName == "") {
            // thread name not already set, use default thread name
            setThreadName(name + "_QuartzSchedulerThread");
        }        
    }