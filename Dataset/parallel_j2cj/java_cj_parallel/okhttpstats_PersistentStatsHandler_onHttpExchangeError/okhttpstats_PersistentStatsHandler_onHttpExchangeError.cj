    public open func onHttpExchangeError (requestStats: RequestStats, e: Exception): Unit {
         if (Utils.isLoggingEnabled) {
             LOGGER.log(LogLevel.DEBUG, "Response Http Error : " + requestStats.toString())
         }
         for (onResponseListener in M_ON_RESPONSE_LISTENERS) {
                 onResponseListener.onResponseError(requestStats, e)
         }
    }