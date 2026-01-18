    public func triggerJob( jobKey: JobKey,  data: JobDataMap) : Unit {
        validateState();

        let trig = TriggerBuilder<OperableTrigger>().withIdentity(newTriggerId(), Scheduler.DEFAULT_GROUP).forJob(jobKey).build();
        trig.computeFirstFireTime(None);

        if(!data.isEmpty()) {
            trig.setJobDataMap(data);
        }

        var collision = true;
        while (collision) {
            try {
                resources.getJobStore().storeTrigger(trig, false);
                collision = false;
            } catch ( oaee: ObjectAlreadyExistsException) {
                trig.setKey(TriggerKey(newTriggerId(), Scheduler.DEFAULT_GROUP));
            }
        }

        notifySchedulerThread(trig.getNextFireTime().getOrThrow().getTime());
        notifySchedulerListenersScheduled(trig);
    }