    public void shutdown(boolean waitForJobsToComplete) {
        
        if(shuttingDown || closed) {
            return;
        }
        
        shuttingDown = true;

        getLog().info(
                "Scheduler " + resources.getUniqueIdentifier()
                        + " shutting down.");
        standby();

        schedThread.halt(waitForJobsToComplete);
        
        notifySchedulerListenersShuttingdown();
        
        if( (resources.isInterruptJobsOnShutdown() && !waitForJobsToComplete) || 
                (resources.isInterruptJobsOnShutdownWithWait() && waitForJobsToComplete)) {
            List<JobExecutionContext> jobs = getCurrentlyExecutingJobs();
            for(JobExecutionContext job: jobs) {
                if(job.getJobInstance() instanceof InterruptableJob)
                    try {
                        ((InterruptableJob)job.getJobInstance()).interrupt();
                    } catch (Throwable e) {
                        // do nothing, this was just a courtesy effort
                        getLog().warn("Encountered error when interrupting job {} during shutdown: {}", job.getJobDetail().getKey(), e);
                    }
            }
        }
        
        resources.getThreadPool().shutdown(waitForJobsToComplete);
        
        closed = true;

        if (resources.getJMXExport()) {
            try {
                unregisterJMX();
            } catch (Exception e) {
            }
        }

        if(boundRemotely) {
            try {
                unBind();
            } catch (RemoteException re) {
            }
        }
        
        shutdownPlugins();

        resources.getJobStore().shutdown();

        notifySchedulerListenersShutdown();

        SchedulerRepository.getInstance().remove(resources.getName());

        holdToPreventGC.clear();
        
        getLog().info(
                "Scheduler " + resources.getUniqueIdentifier()
                        + " shutdown complete.");
    }
