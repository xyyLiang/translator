    public func newJob( bundle: TriggerFiredBundle,  scheduler: Scheduler) : Job {

        let job = super.newJob(bundle, scheduler);

        let csOpt = job as BeanSupport
        let cs = csOpt ?? return job
        
        let jobDataMap = JobDataMap();
        jobDataMap.putAll(scheduler.getContext());
        jobDataMap.putAll(bundle.getJobDetail().getJobDataMap());
        jobDataMap.putAll(bundle.getTrigger().getJobDataMap());

        for( (key,value) in jobDataMap ) {
            var str = ""
            
            match( value ) {
                case s: String => str = s 
                case ts: ToString => str = ts.toString()
                case _ => continue;
            }
            
            try {
                cs.setFieldValue(key,str)
            } catch(e: Exception) {
                log.error("newJob setFieldValue exception, job: ${bundle.getJobDetail().getKey()} key: ${key}, e:${e.message}" ,e )
            }
            
        }

        return job;
    }