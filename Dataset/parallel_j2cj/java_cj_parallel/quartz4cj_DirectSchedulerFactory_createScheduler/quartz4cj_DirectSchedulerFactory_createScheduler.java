    public void createScheduler(String schedulerName,
                                String schedulerInstanceId, ThreadPool threadPool,
                                ThreadExecutor threadExecutor,
                                JobStore jobStore, Map<String, SchedulerPlugin> schedulerPluginMap,
                                String rmiRegistryHost, int rmiRegistryPort,
                                long idleWaitTime, long dbFailureRetryInterval,
                                boolean jmxExport, String jmxObjectName,
                                int maxBatchSize, long batchTimeWindow,
                                boolean makeSchedThreadDaemon)
            throws SchedulerException {

        // Currently only one run-shell factory is available...
        JobRunShellFactory jrsf = new StdJobRunShellFactory();

        // Fire everything up
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        threadPool.setInstanceName(schedulerName);
        threadPool.initialize();
        
        QuartzSchedulerResources qrs = new QuartzSchedulerResources();

        qrs.setName(schedulerName);
        qrs.setInstanceId(schedulerInstanceId);
        qrs.setMakeSchedulerThreadDaemon(makeSchedThreadDaemon);
        SchedulerDetailsSetter.setDetails(threadPool, schedulerName, schedulerInstanceId);
        qrs.setJobRunShellFactory(jrsf);
        qrs.setThreadPool(threadPool);
        qrs.setThreadExecutor(threadExecutor);
        qrs.setJobStore(jobStore);
        qrs.setMaxBatchSize(maxBatchSize);
        qrs.setBatchTimeWindow(batchTimeWindow);
        qrs.setRMIRegistryHost(rmiRegistryHost);
        qrs.setRMIRegistryPort(rmiRegistryPort);
        qrs.setJMXExport(jmxExport);
        if (jmxObjectName != null) {
           qrs.setJMXObjectName(jmxObjectName);
        }
        
        // add plugins
        if (schedulerPluginMap != null) {
            for (Iterator<SchedulerPlugin> pluginIter = schedulerPluginMap.values().iterator(); pluginIter.hasNext();) {
                qrs.addSchedulerPlugin(pluginIter.next());
            }
        }

        QuartzScheduler qs = new QuartzScheduler(qrs, idleWaitTime, dbFailureRetryInterval);

        ClassLoadHelper cch = new CascadingClassLoadHelper();
        cch.initialize();

        SchedulerDetailsSetter.setDetails(jobStore, schedulerName, schedulerInstanceId);

        jobStore.initialize(cch, qs.getSchedulerSignaler());

        Scheduler scheduler = new StdScheduler(qs);

        jrsf.initialize(scheduler);

        qs.initialize();
        

        // Initialize plugins now that we have a Scheduler instance.
        if (schedulerPluginMap != null) {
            for (Iterator<Entry<String, SchedulerPlugin>> pluginEntryIter = schedulerPluginMap.entrySet().iterator(); pluginEntryIter.hasNext();) {
                Entry<String, SchedulerPlugin> pluginEntry = pluginEntryIter.next();

                pluginEntry.getValue().initialize(pluginEntry.getKey(), scheduler, cch);
            }
        }

        getLog().info("Quartz scheduler '" + scheduler.getSchedulerName());

        getLog().info("Quartz scheduler version: " + qs.getVersion());

        SchedulerRepository schedRep = SchedulerRepository.getInstance();

        qs.addNoGCObject(schedRep); // prevents the repository from being
        // garbage collected

        schedRep.bind(scheduler);
        
        initialized = true;
    }
