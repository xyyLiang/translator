    static func createChain(blockIndex:Int64,task:DownloadTask,info:BreakpointInfo,cache:DownloadCache,store:DownloadStore):DownloadChain{
         return DownloadChain(blockIndex, task, info, cache, store)
    }