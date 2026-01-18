    public func prepareRawCall(): okhttp.Call {
        let client = okhttp.OkHttpClient.builder().build()
        let originalRequest = okhttp.Request.builder().build()
        let realcall =  okhttp.RealCall.newRealCall(client, originalRequest, false)
        return realcall.clone()
    }