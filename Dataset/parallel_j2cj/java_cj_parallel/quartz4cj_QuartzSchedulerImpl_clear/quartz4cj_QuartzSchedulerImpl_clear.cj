    public func clear() : Unit {
        validateState();

        resources.getJobStore().clearAllSchedulingData();
        notifySchedulerListenersUnscheduled(TriggerKey.EMPTY_KEY); // 传 EMPTY_KEY 表示全部
    }