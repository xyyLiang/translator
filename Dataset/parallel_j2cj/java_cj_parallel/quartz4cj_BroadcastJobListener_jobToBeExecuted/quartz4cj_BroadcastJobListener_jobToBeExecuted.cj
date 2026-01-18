    public func jobToBeExecuted( context: JobExecutionContext) : Unit {
        for(jl in listeners) {
            jl.jobToBeExecuted(context);
        }
    }