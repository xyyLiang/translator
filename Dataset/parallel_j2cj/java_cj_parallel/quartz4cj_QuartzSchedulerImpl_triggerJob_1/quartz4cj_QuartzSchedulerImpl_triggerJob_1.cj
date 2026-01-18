    public func triggerJob( trig: OperableTrigger)  : Unit {
        validateState();

        trig.computeFirstFireTime(None);

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