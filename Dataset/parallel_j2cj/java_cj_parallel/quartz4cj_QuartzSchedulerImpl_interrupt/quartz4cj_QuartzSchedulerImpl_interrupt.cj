    public func interrupt( jobKey: JobKey) : Bool {

        let jobs = getCurrentlyExecutingJobs();
        
        var interrupted = false;
        
        for(jec in jobs) {
            if (jobKey == jec.getJobDetail().getKey() ) {

                let job = jec.getJobInstance();
                match( job ) {
                    case ij: InterruptableJob => 
                        ij.interrupt(); 
                        interrupted = true
                    case _ =>
                        throw UnableToInterruptJobException( "Job  ${jec.getJobDetail().getKey()} can not be interrupted, since it does not implement " ); //   InterruptableJob.class.getName()
                }
            }                        
        }
        
        return interrupted;
    }
