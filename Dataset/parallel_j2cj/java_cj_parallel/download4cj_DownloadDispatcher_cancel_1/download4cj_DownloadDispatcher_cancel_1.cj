    func cancel(task:DownloadTask):Bool{
        skipProceedCallCount.fetchAdd(1)
        let result:Bool = cancelLocked(task)
        skipProceedCallCount.fetchSub(1)
        return result
    }