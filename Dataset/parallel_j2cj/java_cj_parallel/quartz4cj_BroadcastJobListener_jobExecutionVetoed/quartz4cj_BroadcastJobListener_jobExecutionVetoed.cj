    public func jobExecutionVetoed( context: JobExecutionContext) : Unit  {
        for(jl in listeners) {
            jl.jobExecutionVetoed(context);
        }
    }