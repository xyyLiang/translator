    public open func httpExchangeError (inspectorRequest: NetworkEventReporterInspectorRequest, e: Exception): Unit {
              var requestId: Int64 = inspectorRequest.requestId()
              var requestStats: RequestStats = RequestStats(requestId)
              requestStats.requestSize = inspectorRequest.requestSize()
              requestStats.url = inspectorRequest.url()
              requestStats.methodType = inspectorRequest.method()
              requestStats.hostName = inspectorRequest.hostName()
              requestStats.requestBody = inspectorRequest.requestBody()
              match (mNetworkRequestStatsHandler){
                  case Some(x) => x.onHttpExchangeError(requestStats, e)
                  case None => ()
              }
    }