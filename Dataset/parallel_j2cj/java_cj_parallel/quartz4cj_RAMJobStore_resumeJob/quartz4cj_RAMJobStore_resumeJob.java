    public void resumeJob(JobKey jobKey) {

        synchronized (lock) {
            List<OperableTrigger> triggersOfJob = getTriggersForJob(jobKey);
            for (OperableTrigger trigger: triggersOfJob) {
                resumeTrigger(trigger.getKey());
            }
        }
    }