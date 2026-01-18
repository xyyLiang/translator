    public func generateRequestBuilder(requestBody: okhttp.RequestBody): okhttp.RequestBuilder {
        try {
            getHeaders(HttpHeaders.HEAD_KEY_CONTENT_LENGTH, "${requestBody.contentLength()}")
            ()
        } catch (e: IOException) {
            e.printStackTrace()
        }
        var requestBuilder: okhttp.RequestBuilder = okhttp.Request.builder()
        return HttpUtils.appendHeaders(requestBuilder, headers)
    }