    public func createScheduler( threadPool!: ThreadPool,
                                 jobStore! : JobStore, 
                                 schedulerName! : String = DEFAULT_SCHEDULER_NAME,
                                 schedulerInstanceId! : String = DEFAULT_INSTANCE_ID,  
                                 threadExecutor! : ThreadExecutor = DEFAULT_THREAD_EXECUTOR,
                                 schedulerPluginMap! : HashMap<String, SchedulerPlugin> = HashMap(),
                                 idleWaitTime! : Int64 = -1,
                                 maxBatchSize!: Int64 = DEFAULT_BATCH_MAX_SIZE, 
                                 batchTimeWindow!: Int64 = DEFAULT_BATCH_TIME_WINDOW) : Unit {


        let jobFactory = PropertySettingJobFactory() 
        let jrsf = StdJobRunShellFactory();
 
        threadPool.setInstanceName(schedulerName)
        threadPool.setInstanceId(schedulerInstanceId) 
        
        let qrs = QuartzSchedulerResources();

        let threadName = schedulerName+ "_QuartzSchedulerThread";

        qrs.setName(schedulerName);
        qrs.setThreadName(threadName);
        qrs.setInstanceId(schedulerInstanceId);

        qrs.setJobRunShellFactory(jrsf);
        qrs.setThreadPool(threadPool);
        qrs.setThreadExecutor(threadExecutor);
        qrs.setJobStore(jobStore);
        qrs.setMaxBatchSize(maxBatchSize);
        qrs.setBatchTimeWindow(batchTimeWindow);
        
        threadExecutor.initialize();
        threadPool.initialize();

        for (p in schedulerPluginMap.values() ) {
            qrs.addSchedulerPlugin(p );
        }

        let qs = QuartzSchedulerImpl(qrs, jobFactory, idleWaitTime);

        jobStore.setInstanceName(schedulerName)
        jobStore.setInstanceId(schedulerInstanceId) 
        jobStore.initialize(qs.getSchedulerSignaler());

        let scheduler = StdScheduler(qs);

        jrsf.initialize(scheduler);

        qs.initialize();
        
        for( (key,p) in schedulerPluginMap ) {
            p.initialize(key,scheduler)
        }

        log.info("Quartz scheduler '" + scheduler.getSchedulerName());
        log.info("Quartz scheduler version: " + qs.getVersion());

        let schedRep = SchedulerRepository.getInstance();

        qs.addNoGCObject(schedRep); // prevents the repository from being garbage collected

        schedRep.bind(scheduler);
        
        initialized = true;
    }