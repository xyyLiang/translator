    public func interceptConnect(chain:DownloadChain):Option<DownloadConnectionConnected>{
         let info: BreakpointInfo = chain.getInfo()
        let connection: DownloadConnection = chain.getConnectionOrCreate()
        let task: DownloadTask = chain.getTask()
        let userHeader: Option<HashMap<String,ArrayList<String>>> =  task.getHeaderMapFields()
        if(let Some(_) <- userHeader) {
            Util.addUserRequestHeaderField(userHeader.getOrThrow(), connection)
        }
        if(Option<HashMap<String,ArrayList<String>>>.None == userHeader || !userHeader.getOrThrow().contains(Util.USER_AGENT)) {
            Util.addDefaultUserAgent(connection)
        }
        let blockIndex:Int64 = chain.getBlockIndex()
        let blockInfo:Option<BlockInfo> =  info.getBlock(blockIndex)
        if (let Some(_) <- blockInfo) {
        } else {
                throw ReadWriteException("No block-info found on " + blockIndex.toString())
        }
        var range:String = "bytes=" + blockInfo.getOrThrow().getRangeLeft().toString() + "-"
        range = range +  blockInfo.getOrThrow().getRangeRight().toString()
        connection.addHeader(Util.RANGE, range)
        Util.d(TAG, "AssembleHeaderRange (" + task.getId().toString() + ") block(" + blockIndex.toString() + ") "+ "downloadFrom(" + blockInfo.getOrThrow().getRangeLeft().toString() + ") currentOffset("  + blockInfo.getOrThrow().getCurrentOffset().toString() + ")")
        if (chain.getCache().isInterrupt()) {
            throw InterruptException.SIGNAL
        }
        Download4cj.withs().callbackDispatcher().dispatch().connectStart(task, blockIndex, connection.getRequestProperties())
        var connected:DownloadConnectionConnected = chain.processConnect()
        if (chain.getCache().isInterrupt()) {
            throw InterruptException.SIGNAL
        }
        var responseHeaderFields:Option<HashMap<String,ArrayList<String>>> = connected.getResponseHeaderFields()
        if (Option<HashMap<String,ArrayList<String>>>.None == responseHeaderFields) {
            responseHeaderFields = HashMap<String,ArrayList<String>>()
        }
        Download4cj.withs().callbackDispatcher().dispatch().connectEnd(task, blockIndex,connected.getResponseCode(), responseHeaderFields.getOrThrow())
        let strategy:DownloadStrategy = Download4cj.withs().downloadStrategy()
        let responseCheck:ResumeAvailableResponseCheck =  strategy.resumeAvailableResponseCheck(connected, blockIndex, info)
        responseCheck.inspect()
        var contentLength:Int64 = 0
        let contentLengthField:Option<String> = connected.getResponseHeaderField(Util.CONTENT_LENGTH)
        if(Option<String>.None != contentLengthField && contentLengthField.getOrThrow().size > 0){
            contentLength = Util.parseContentLength(contentLengthField)
        }
        chain.setResponseContentLength(contentLength)
        return connected

    }