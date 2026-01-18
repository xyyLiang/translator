    public func requestSync(cacheEntity: CacheEntity): okhttp_okcj.Response {
        var resp: okhttp.Response = rawCall.execute()
        try {
            prepareRawCall()
        } catch (e: Exception) {
            return Response.error(false, rawCall, resp, e)
        }
        var response: okhttp_okcj.Response = requestNetworkSync()
        if (response.isSuccessful() && response.code() == 304) {
            response = Response.success(true, cacheEntity.getData(), rawCall, response.getRawResponse())
        }
        return response
    }