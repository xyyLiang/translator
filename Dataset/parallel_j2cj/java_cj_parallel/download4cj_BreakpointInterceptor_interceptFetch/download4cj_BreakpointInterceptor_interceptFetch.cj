    public func interceptFetch(chain:DownloadChain):Int64{
        let contentLength:Int64 = chain.getResponseContentLength()
        let blockIndex:Int64 = chain.getBlockIndex()
        let isNotChunked:Bool = contentLength != Util.CHUNKED_CONTENT_LENGTH
        var fetchLength:Int64 = 0
        var processFetchLength:Int64 = 0
        let outputStream:MultiPointOutputStream = chain.getOutputStream()
        try {
            while (true) {
                processFetchLength = chain.loopFetch()
                if (processFetchLength <= 0) {
                    break
                }
                fetchLength += processFetchLength
            }
        }catch(e:Exception){
            println("reason="+e.message.toString())
        }finally{
            chain.flushNoCallbackIncreaseBytes()
            if (!chain.getCache().isUserCanceled()){
                 outputStream.done(blockIndex)
            }
        }
        if (isNotChunked) {
            if (fetchLength != contentLength) {
                throw  ReadWriteException("Fetch-length isn't equal to the response content-length, "+ fetchLength.toString() + "!= " + contentLength.toString())
            }
        }
        return fetchLength
    }