    public void standby() {
        resources.getJobStore().schedulerPaused();
        schedThread.togglePause(true);
        getLog().info(
                "Scheduler " + resources.getUniqueIdentifier() + " paused.");
        notifySchedulerListenersInStandbyMode();        
    }