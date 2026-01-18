    func enqueue(task:DownloadTask):Unit{
        skipProceedCallCount.fetchAdd(1)
        enqueueLocked(task)
        skipProceedCallCount.fetchSub(1)
    }