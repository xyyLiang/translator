    public open func newJob(bundle: TriggerFiredBundle, scheduler: Scheduler) : Job {

        let jobDetail = bundle.getJobDetail()
        let jobClass = jobDetail.getJobClass()
        try {
            if( log.isDebugEnabled()) {
                log.debug("Producing instance of Job '${jobDetail.getKey()}', class=${jobClass.getClass()}")
            }
            return jobClass.newInstance();
        } catch (e: Exception) {
            throw SchedulerException( "Problem instantiating class '${jobDetail.getJobClass().getClass()}'" + e.message )
        }
    }