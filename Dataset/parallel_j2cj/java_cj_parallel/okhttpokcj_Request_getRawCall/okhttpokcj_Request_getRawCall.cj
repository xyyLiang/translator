    public func getRawCall(): okhttp.Call {
        
        var reqb: okhttp.RequestBody = RequestBody("text/plain", "application/json")
        var progressRequestBody: ProgressRequestBody = ProgressRequestBody(reqb)
        progressRequestBody.setInterceptor(uploadInterceptor)
        mRequest = generationRequest(progressRequestBody)
        client = OkCj.getInstance().getOkHttpClient()
        return client.newCall(mRequest)
    }