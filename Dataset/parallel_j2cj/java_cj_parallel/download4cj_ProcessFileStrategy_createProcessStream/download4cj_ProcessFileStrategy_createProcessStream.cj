     func createProcessStream(task:DownloadTask,info:BreakpointInfo,store:DownloadStore):MultiPointOutputStream{
        return MultiPointOutputStream(task,info,store)
    }