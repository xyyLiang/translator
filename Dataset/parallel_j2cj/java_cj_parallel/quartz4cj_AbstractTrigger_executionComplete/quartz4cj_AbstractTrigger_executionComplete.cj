    public func executionComplete(context: JobExecutionContext, result: ?JobExecutionException): CompletedExecutionInstruction {
        if(let Some(v) <- result) {
            if (v.refireImmediately()) {
                return CompletedExecutionInstruction.RE_EXECUTE_JOB
            }
            if (v.unscheduleFiringTrigger()) {
                return CompletedExecutionInstruction.SET_TRIGGER_COMPLETE
            }
        
            if (v.unscheduleAllTriggers()) {
                return CompletedExecutionInstruction.SET_ALL_JOB_TRIGGERS_COMPLETE
            }    
        }
    
        if (!mayFireAgain()) {
            return CompletedExecutionInstruction.DELETE_TRIGGER
        }
    
        return CompletedExecutionInstruction.NOOP
    }