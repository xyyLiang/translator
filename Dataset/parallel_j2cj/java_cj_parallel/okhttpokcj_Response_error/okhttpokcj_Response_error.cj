    public static func error(isFromCache: Bool, rawCall: okhttp.Call, rawResponse: okhttp.Response, e: Exception): okhttp_okcj.Response {
        var response: okhttp_okcj.Response = Response()
        response.setFromCache(isFromCache);
        response.setRawCall(rawCall);
        response.setRawResponse(rawResponse);
        response.setException(e);
        return response
    }