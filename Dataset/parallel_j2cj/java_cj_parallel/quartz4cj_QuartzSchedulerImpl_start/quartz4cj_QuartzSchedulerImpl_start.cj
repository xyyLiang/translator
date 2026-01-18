    public func start() : Unit {

        if (shuttingDown || closed) {
            throw SchedulerException( "The Scheduler cannot be restarted after shutdown() has been called.");
        }

        // QTZ-212 : calling new schedulerStarting() method on the listeners right after entering start()
        notifySchedulerListenersStarting();

        if (!initialStart.isPresent() ) {
            initialStart = DateTime.now()
            this.resources.getJobStore().schedulerStarted();            
            startPlugins();
        } else {
            resources.getJobStore().schedulerResumed();
        }

        getSchedThread().togglePause(false);

        log.info( "Scheduler " + resources.getUniqueIdentifier() + " started.");
        
        notifySchedulerListenersStarted();
    }