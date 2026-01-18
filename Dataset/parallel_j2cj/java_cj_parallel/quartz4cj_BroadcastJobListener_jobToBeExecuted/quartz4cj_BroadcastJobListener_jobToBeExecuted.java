    public void jobToBeExecuted(JobExecutionContext context) {

        Iterator<JobListener> itr = listeners.iterator();
        while(itr.hasNext()) {
            JobListener jl = itr.next();
            jl.jobToBeExecuted(context);
        }
    }