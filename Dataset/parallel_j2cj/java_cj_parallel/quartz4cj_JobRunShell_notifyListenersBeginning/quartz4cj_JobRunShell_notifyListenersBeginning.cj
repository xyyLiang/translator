    private func notifyListenersBeginning( jobExCtxt: JobExecutionContext) : Bool  {
 
        var vetoed = false;

        // notify all trigger listeners
        try {
            vetoed = qs.notifyTriggerListenersFired(jobExCtxt)
        } catch ( se: SchedulerException) {
            qs.notifySchedulerListenersError(
                    "Unable to notify TriggerListener(s) while firing trigger  (Trigger and Job will NOT be fired!). trigger=  ${jobExCtxt.getTrigger().getKey()} job= ${jobExCtxt.getJobDetail().getKey()}", se);

            return false;
        }

        if(vetoed) { 
            try {
                qs.notifyJobListenersWasVetoed(jobExCtxt);
            } catch ( se: SchedulerException) {
                qs.notifySchedulerListenersError(
                        "Unable to notify JobListener(s) of vetoed execution  while firing trigger (Trigger and Job will NOT be  fired!). trigger=  ${jobExCtxt.getTrigger().getKey()} job= ${jobExCtxt.getJobDetail().getKey()}", se);

            }
            throw VetoedException();
        }

        // notify all job listeners
        try {
            qs.notifyJobListenersToBeExecuted(jobExCtxt);
        } catch ( se: SchedulerException) {
            qs.notifySchedulerListenersError(
                    "Unable to notify JobListener(s) of Job to be executed: " +
                            "(Job will NOT be executed!). trigger= ${jobExCtxt.getTrigger().getKey()} job= ${jobExCtxt.getJobDetail().getKey()}" , se);

            return false;
        }

        return true;
    }