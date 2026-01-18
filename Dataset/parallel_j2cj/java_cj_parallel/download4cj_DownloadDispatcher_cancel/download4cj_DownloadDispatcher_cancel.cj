    func cancel(tasks:Array<DownloadTask>):Unit{
        skipProceedCallCount.fetchAdd(1)
        cancelLocked(tasks)
        skipProceedCallCount.fetchSub(1)
    }