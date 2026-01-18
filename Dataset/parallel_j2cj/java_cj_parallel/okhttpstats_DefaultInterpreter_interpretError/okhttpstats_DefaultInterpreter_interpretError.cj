    public open func interpretError (requestId: Int64, timeInfo: NetworkInterceptorTimeInfo, request: Request, e: Exception): Unit {
        if (Utils.isLoggingEnabled) {
            LOGGER.log(LogLevel.DEBUG, "Error response: interpretError: ${e} ${timeInfo.mStartTime.toString()}")
        }
        var okHttpInspectorRequest = DefaultInterpreterOkHttpInspectorRequest(requestId, request.getUrl(), request.getMethod(), Utils.contentLength(request.getHeaders()), request.getUrl().hostname(), request.getBody())
        match(mEventReporter){
            case Some(x) => x.httpExchangeError(okHttpInspectorRequest, e)
            case None => ()
        }
    }