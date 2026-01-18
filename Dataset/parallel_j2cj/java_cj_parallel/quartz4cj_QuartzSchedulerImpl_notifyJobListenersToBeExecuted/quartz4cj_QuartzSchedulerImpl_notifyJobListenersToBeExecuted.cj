    public func notifyJobListenersToBeExecuted( jec: JobExecutionContext): Unit {
        // build a list of all job listeners that are to be notified...
        let jobListeners = buildJobListenerList();

        // notify all job listeners
        for( jl in jobListeners) {
            try {
                if(!matchJobListener(jl, jec.getJobDetail().getKey())) {
                    continue;
                }
                jl.jobToBeExecuted(jec);
            } catch (e:Exception) {
                let se = SchedulerException( "JobListener '${jl.getName()}' threw exception: "+ e.message );
                throw se;
            }
        }
    }