    public func jobWasExecuted(context: JobExecutionContext,  jobException: ?JobExecutionException) : Unit  {
        for(jl in listeners) {
            jl.jobWasExecuted(context, jobException);
        }
    }
