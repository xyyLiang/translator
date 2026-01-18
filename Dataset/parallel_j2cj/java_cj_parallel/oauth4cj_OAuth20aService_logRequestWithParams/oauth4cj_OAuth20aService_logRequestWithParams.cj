
    protected func logRequestWithParams(requestDescription: String, request: OAuth4cjRequest): Unit {
        if (isDebug()) {
            let body: String = request.getBodyParams().asFormUrlEncodedString()
            let query: String = request.getQueryStringParams().asFormUrlEncodedString()
            log("created ${requestDescription} request with body params [${body}], query string params [${query}]")
        }
    }