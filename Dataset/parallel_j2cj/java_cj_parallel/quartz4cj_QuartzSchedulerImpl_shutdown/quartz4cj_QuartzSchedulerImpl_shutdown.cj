    public func shutdown( waitForJobsToComplete: Bool ) : Unit {
        
        if(shuttingDown || closed) {
            return;
        }
        
        shuttingDown = true;

        log.info("Scheduler ${resources.getUniqueIdentifier()} shutting down.");

        standby();
        getSchedThread().halt(waitForJobsToComplete);

        notifySchedulerListenersShuttingdown();
        
        if( (resources.isInterruptJobsOnShutdown() && !waitForJobsToComplete) || 
                (resources.isInterruptJobsOnShutdownWithWait() && waitForJobsToComplete)) {
            let jobs = getCurrentlyExecutingJobs();
            for( job in jobs) {
                let ijOpt = job as InterruptableJob
                let ij = ijOpt ?? continue;
                try {
                    ij.interrupt()
                } catch (e: Exception ) {
                    // do nothing, this was just a courtesy effort
                    log.error("Encountered error when interrupting job ${job.getJobDetail().getKey()} during shutdown", e);
                }
            }
        }

        resources.getThreadPool().shutdown(waitForJobsToComplete);

        closed = true;

        shutdownPlugins();

        resources.getJobStore().shutdown();

        notifySchedulerListenersShutdown();

        SchedulerRepository.getInstance().remove(resources.getName());

        holdToPreventGC.clear();
        
        log.info( "Scheduler ${resources.getUniqueIdentifier()} shutdown complete.");
    }