    public func onAnalysisResponse(call: okhttp.Call, response: okhttp.Response): Bool {

        if (response.getCode() != 304) {
            return false
        }

        let success: okhttp_okcj.Response = Response.success(true, cacheEntity.getData(), call, response)
        spawn {
            mCallback.onCacheSuccess(success)
            mCallback.onFinish()
        }
        return true
    }