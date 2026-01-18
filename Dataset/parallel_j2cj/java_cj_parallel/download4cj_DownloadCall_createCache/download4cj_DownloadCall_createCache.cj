    func createCache(info:BreakpointInfo):DownloadCache{
        let outputStream:MultiPointOutputStream = Download4cj.withs().processFileStrategy().createProcessStream(task, info, store)
        return DownloadCache(outputStream)
    }