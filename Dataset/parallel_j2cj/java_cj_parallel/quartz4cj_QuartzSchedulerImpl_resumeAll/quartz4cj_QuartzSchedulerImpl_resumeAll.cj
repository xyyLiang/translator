    public func resumeAll() : Unit {
        validateState();

        resources.getJobStore().resumeAll();
        notifySchedulerThread(0);
        notifySchedulerListenersResumedTriggers("");  // 传 "" 表示全部, quartz 原有代码这里有 bug,， 少写了一个 s, 已修复
    }
