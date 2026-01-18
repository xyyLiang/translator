    public open func onResponseInputStreamError (requestStats: RequestStats, e: Exception): Unit {
         if (Utils.isLoggingEnabled) {
             LOGGER.log(LogLevel.DEBUG, "Response InputStream : "+ requestStats.toString())
         }
         for (onResponseListener in M_ON_RESPONSE_LISTENERS) {
                 onResponseListener.onResponseError(requestStats, e)
         }
    }