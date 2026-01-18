    public func pauseAll() : Unit {
        validateState();

        resources.getJobStore().pauseAll();
        notifySchedulerThread(0);
        notifySchedulerListenersPausedTriggers(""); // 传 "" 表示全部
    }