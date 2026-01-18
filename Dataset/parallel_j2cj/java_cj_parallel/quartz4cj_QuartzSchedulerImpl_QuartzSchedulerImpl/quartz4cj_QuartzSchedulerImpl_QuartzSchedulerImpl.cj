    public QuartzSchedulerImpl( resources: QuartzSchedulerResources, jobFactory: JobFactory, idleWaitTime: Int64)  {
        this.resources = resources;
        this.jobFactory = jobFactory

        let jlOpt = resources.getJobStore() as JobListener
        if ( let Some(jsjl) <- jlOpt ) {
            if( jsjl.getName() != "" ) {
                throw IllegalArgumentException( "JobListener name cannot be empty.");
            }
            internalJobListeners.put(jsjl.getName(), jsjl);
        }

        jobMgr = ExecutingJobsManager();
        internalJobListeners.put(jobMgr.getName(), jobMgr);

        errLogger = ErrorLogger();
        internalSchedulerListeners.append(errLogger);

        let schedThread = QuartzSchedulerThread(this, resources);
        if (idleWaitTime > 0) {
            schedThread.setIdleWaitTime(idleWaitTime);
        }
        this.schedThread = schedThread

        this.signaler = SchedulerSignalerImpl(this, schedThread);
        
        resources.getThreadExecutor().execute(schedThread);

        log.info("Quartz Scheduler v" + getVersion() + " created.");
    }
