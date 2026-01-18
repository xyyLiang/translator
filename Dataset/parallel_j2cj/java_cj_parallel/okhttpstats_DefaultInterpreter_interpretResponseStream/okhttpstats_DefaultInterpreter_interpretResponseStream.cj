    public open func interpretResponseStream (requestId: Int64, timeInfo: NetworkInterceptorTimeInfo, request: Request, response: Response): Response {
        var responseBody: Option<ResponseBody> = response.getBody()
        var responseRes = response

        var okHttpInspectorRequest: DefaultInterpreterOkHttpInspectorRequest =
        DefaultInterpreterOkHttpInspectorRequest(requestId, request.getUrl(), request.getMethod(), Utils.contentLength(request.getHeaders()), request.getUrl().hostname(), request.getBody())

        var okHttpInspectorResponse: DefaultInterpreterOkHttpInspectorResponse =
        DefaultInterpreterOkHttpInspectorResponse(requestId, response.getCode(), Utils.contentLength(response.getHeaders()), timeInfo.mStartTime, timeInfo.mEndTime, response.getBody())

        match (responseBody){
            case Some(x) =>
                try {
                    var responseStream = x.getSource()
                    if(mtest){
                        throw IllegalArgumentException("test x.getSource() throwException")
                    }
                } catch (e :Exception) {
                    if (Utils.isLoggingEnabled) {
                        LOGGER.log(LogLevel.DEBUG, "Error reading IS : interpretResponseStream ${e}")
                    }
                    match(mEventReporter){
                        case Some(y) => y.responseInputStreamError(okHttpInspectorRequest, okHttpInspectorResponse, e)
                        case None => ()
                    }
                    throw e
                }
                responseRes = response.newBuilder().body(x).build()
            case None => ()
        }
        match(mEventReporter){
            case Some(x) =>
            x.responseReceived(okHttpInspectorRequest, okHttpInspectorResponse)
            case None => ()
        }
        return responseRes
    }
