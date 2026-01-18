    public func requestAsync(cacheEntity: CacheEntity, callback: Callback): Unit {
        mCallback = callback
        let resp: okhttp.Response = rawCall.execute()
        spawn {
            mCallback.onStart(request)
            try {
                prepareRawCall()
            } catch (e: Exception) {
                var error: okhttp_okcj.Response = Response.error(false, rawCall, resp, e)
                mCallback.onError(error)
                return
            }
            var success: okhttp_okcj.Response = Response.success(true, cacheEntity.getData(), rawCall, resp)
            mCallback.onCacheSuccess(success)
            requestNetworkAsync()
        }
    }