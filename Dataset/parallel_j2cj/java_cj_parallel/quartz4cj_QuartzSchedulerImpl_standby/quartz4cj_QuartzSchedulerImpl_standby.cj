    public func standby()  : Unit {
        resources.getJobStore().schedulerPaused();
        getSchedThread().togglePause(true);
        log.info(  "Scheduler ${resources.getUniqueIdentifier()} paused.");
        notifySchedulerListenersInStandbyMode();        
    }