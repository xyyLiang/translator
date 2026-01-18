    public func unscheduleJob( triggerKey: TriggerKey) : Bool {
        validateState();

        if (resources.getJobStore().removeTrigger(triggerKey)) {
            notifySchedulerThread(0);
            notifySchedulerListenersUnscheduled(triggerKey);
        } else {
            return false;
        }

        return true;
    }