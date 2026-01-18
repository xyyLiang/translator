    public static func success(isFromCache: Bool, body: String, rawCall: okhttp.Call, rawResponse: okhttp.Response): okhttp_okcj.Response {
        var response: okhttp_okcj.Response = Response()
        response.setFromCache(isFromCache)
        response.setBody(body)
        response.setRawCall(rawCall)
        response.setRawResponse(rawResponse)
        return response
    }