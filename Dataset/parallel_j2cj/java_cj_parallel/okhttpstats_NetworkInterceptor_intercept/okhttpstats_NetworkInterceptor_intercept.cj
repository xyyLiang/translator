    public func intercept (chain: Chain): Response {
        var requestId: Int64 = mNextRequestId.fetchAdd(1)
        var request: Request = chain.getRequest()
        var timeInfo: NetworkInterceptorTimeInfo = NetworkInterceptorTimeInfo()
        var response: Response
        try {
            timeInfo.mStartTime = Time.now()
            response = chain.proceed(request)
            timeInfo.mEndTime = Time.now()
            if (mtest){
                throw IllegalArgumentException("test chain.proceed(request) throwException")
            }
        } catch (e: Exception) {
            if (Utils.isLoggingEnabled) {
                LOGGER.log(LogLevel.DEBUG, "interceptError : ${e}")
            }
            if (mEnabled) {
                match (mInterpreter){
                    case Some(x) => x.interpretError(requestId, timeInfo, request, e)
                    case None => ()
                }
            }
            throw e
        }
        if (Utils.isLoggingEnabled) {
            LOGGER.log(LogLevel.DEBUG, "interceptSecess")
        }
        if (mEnabled) {
             match (mInterpreter) {
                   case Some(x) => response = x.interpretResponseStream(requestId, timeInfo, request, response)
                   case None => ()
                }
        }
        return response
    }