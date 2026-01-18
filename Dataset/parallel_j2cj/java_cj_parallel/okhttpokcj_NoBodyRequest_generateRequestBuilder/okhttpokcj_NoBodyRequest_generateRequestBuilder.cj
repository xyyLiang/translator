    public func generateRequestBuilder(requestBody: okhttp.RequestBody): okhttp.RequestBuilder {
        url = HttpUtils.createUrlFromParams(baseUrl, params.urlParamsMap)
        var requestBuilder = okhttp.Request.builder()
        return HttpUtils.appendHeaders(requestBuilder, headers)
    }