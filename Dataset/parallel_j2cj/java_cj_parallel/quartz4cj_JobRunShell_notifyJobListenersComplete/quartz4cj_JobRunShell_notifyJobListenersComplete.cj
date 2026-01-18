    private func notifyJobListenersComplete( jobExCtxt: JobExecutionContext,  jobExEx: ?JobExecutionException) : Bool {
        try {
            qs.notifyJobListenersWasExecuted(jobExCtxt, jobExEx);
        } catch ( se: SchedulerException) {
            qs.notifySchedulerListenersError(
                    "Unable to notify JobListener(s) of Job that was executed: " +
                            "(error will be ignored). trigger= ${jobExCtxt.getTrigger().getKey()} " +
                            " job= ${jobExCtxt.getJobDetail().getKey()}"  , se);

            return false;
        }

        return true;
    }