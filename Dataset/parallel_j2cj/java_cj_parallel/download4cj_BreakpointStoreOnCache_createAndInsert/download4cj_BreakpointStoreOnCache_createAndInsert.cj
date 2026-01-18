    public func createAndInsert(task:DownloadTask):BreakpointInfo{
        let id:Int64 = task.getId()
        var newInfo:BreakpointInfo = BreakpointInfo(id,task.getUrl(),task.getParentFile(), task.getFilename().getOrThrow())
        synchronized(m){
            storedInfos.put(id, newInfo)
            unStoredTasks.remove(id)
        }
        return newInfo
    }