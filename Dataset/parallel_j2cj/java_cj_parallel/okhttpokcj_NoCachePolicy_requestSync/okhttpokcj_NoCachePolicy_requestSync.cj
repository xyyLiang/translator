    public func requestSync(cacheEntity: CacheEntity): okhttp_okcj.Response {
        var resp: okhttp.Response = rawCall.execute()
        try {
            prepareRawCall()
        } catch (e: Exception) {
            return Response.error(false, rawCall, resp, e)
        }
        return requestNetworkSync()
    }