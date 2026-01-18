    public func interrupt( fireInstanceId: String) : Bool {
        let jobs = getCurrentlyExecutingJobs();
        
        for(jec in jobs) {
            if (jec.getFireInstanceId() == fireInstanceId ) {
                let job = jec.getJobInstance();
                match( job ) {
                    case ij: InterruptableJob => 
                        ij.interrupt(); 
                        return true
                    case _ =>
                        throw UnableToInterruptJobException( "Job  ${jec.getJobDetail().getKey()} can not be interrupted, since it does not implement " );
                }
            }                        
        }
        
        return false;
    }