    public String getSummary() throws SchedulerException {
        StringBuilder str = new StringBuilder("Quartz Scheduler (v");
        str.append(getVersion());
        str.append(") '");

        str.append(getSchedulerName());
        str.append("' with instanceId '");
        str.append(getSchedulerInstanceId());
        str.append("'\n");

        str.append("  Scheduler class: '");
        str.append(getSchedulerClass().getName());
        str.append("'");
        if (isSchedulerRemote()) {
            str.append(" - access via RMI.");
        } else {
            str.append(" - running locally.");
        }
        str.append("\n");

        if (!isShutdown()) {
            if (getRunningSince() != null) {
                str.append("  Running since: ");
                str.append(getRunningSince());
            } else {
                str.append("  NOT STARTED.");
            }
            str.append("\n");

            if (isInStandbyMode()) {
                str.append("  Currently in standby mode.");
            } else {
                str.append("  Not currently in standby mode.");
            }
        } else {
            str.append("  Scheduler has been SHUTDOWN.");
        }
        str.append("\n");

        str.append("  Number of jobs executed: ");
        str.append(getNumberOfJobsExecuted());
        str.append("\n");

        str.append("  Using thread pool '");
        str.append(getThreadPoolClass().getName());
        str.append("' - with ");
        str.append(getThreadPoolSize());
        str.append(" threads.");
        str.append("\n");

        str.append("  Using job-store '");
        str.append(getJobStoreClass().getName());
        str.append("' - which ");
        if (isJobStoreSupportsPersistence()) {
            str.append("supports persistence.");
        } else {
            str.append("does not support persistence.");
        }
        if (isJobStoreClustered()) {
            str.append(" and is clustered.");
        } else {
            str.append(" and is not clustered.");
        }
        str.append("\n");

        return str.toString();
    }
