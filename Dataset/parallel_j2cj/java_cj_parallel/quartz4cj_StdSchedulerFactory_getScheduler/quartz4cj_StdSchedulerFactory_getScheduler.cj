    public func getScheduler() : Scheduler {
        if (!cfgOpt.isPresent()) {
            initialize();
        }
        let schedRep = SchedulerRepository.getInstance();
        let schedName  = getSchedulerName()
        let schedOpt = schedRep.lookup(schedName);
        if ( let Some(sched) <- schedOpt ) {
            if (sched.isShutdown()) {
                schedRep.remove(schedName);
            } else {
                return sched;
            }
        }
        return instantiate();
    }