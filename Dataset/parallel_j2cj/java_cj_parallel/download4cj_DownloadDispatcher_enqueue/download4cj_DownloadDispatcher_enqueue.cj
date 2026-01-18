    func enqueue(tasks:Array<DownloadTask>):Unit{
        skipProceedCallCount.fetchAdd(1)
        enqueueLocked(tasks)
        skipProceedCallCount.fetchSub(1)
    }