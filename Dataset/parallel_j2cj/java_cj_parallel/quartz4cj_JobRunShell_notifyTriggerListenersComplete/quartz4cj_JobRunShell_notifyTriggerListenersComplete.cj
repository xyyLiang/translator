    private func notifyTriggerListenersComplete( jobExCtxt: JobExecutionContext,  instCode: CompletedExecutionInstruction) : Bool  {
        try {
            qs.notifyTriggerListenersComplete(jobExCtxt, instCode);

        } catch ( se: SchedulerException) {
            qs.notifySchedulerListenersError(
                    "Unable to notify TriggerListener(s) of Job that was executed: " +
                            "(error will be ignored). trigger= ${jobExCtxt.getTrigger().getKey()} " +
                            " job= ${jobExCtxt.getJobDetail().getKey()}"  , se);

            return false;
        }
        if (!jobExCtxt.getTrigger().getNextFireTime().isPresent()) {
            qs.notifySchedulerListenersFinalized(jobExCtxt.getTrigger());
        }

        return true;
    }