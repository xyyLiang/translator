    func start():Unit{
        let dispatcher:CallbackDispatcher =  Download4cj.withs().callbackDispatcher()
        // connect chain
        let retryInterceptor:RetryInterceptor = RetryInterceptor()
        let breakpointInterceptor:BreakpointInterceptor = BreakpointInterceptor()
        connectInterceptorList.append(retryInterceptor)
        connectInterceptorList.append(breakpointInterceptor)
        connectInterceptorList.append(HeaderInterceptor())
        connectInterceptorList.append(CallServerInterceptor())
        connectIndex = 0
        let connected:DownloadConnectionConnected = processConnect()
        if (cache.isInterrupt()) {
            throw InterruptException.SIGNAL
        }
        dispatcher.dispatch().fetchStart(task, blockIndex, getResponseContentLength())
        // fetch chain
        let fetchDataInterceptor:FetchDataInterceptor = FetchDataInterceptor(blockIndex, connected.getInputStream(),getOutputStream(), task)
        fetchInterceptorList.append(retryInterceptor)
        fetchInterceptorList.append(breakpointInterceptor)
        fetchInterceptorList.append(fetchDataInterceptor)
        fetchIndex = 0
        let totalFetchedBytes:Int64 = processFetch()
        dispatcher.dispatch().fetchEnd(task, blockIndex, totalFetchedBytes)
    }