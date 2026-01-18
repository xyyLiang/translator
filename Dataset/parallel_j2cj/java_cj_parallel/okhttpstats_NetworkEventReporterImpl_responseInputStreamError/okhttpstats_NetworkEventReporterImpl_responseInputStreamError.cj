    public open func responseInputStreamError (inspectorRequest: NetworkEventReporterInspectorRequest, inspectorResponse: NetworkEventReporterInspectorResponse, e: Exception): Unit {
                  var requestId: Int64 = inspectorResponse.requestId()
                  var requestStats: RequestStats = RequestStats(requestId)
                  requestStats.requestSize = inspectorRequest.requestSize()
                  requestStats.url = inspectorRequest.url()
                  requestStats.methodType = inspectorRequest.method()
                  requestStats.hostName = inspectorRequest.hostName()
                  requestStats.requestBody = inspectorRequest.requestBody()
                  requestStats.responseSize = inspectorResponse.responseSize()
                  requestStats.statusCode = inspectorResponse.statusCode()
                  requestStats.startTime = inspectorResponse.startTime()
                  requestStats.endTime = inspectorResponse.endTime()
                  requestStats.responseBody = inspectorResponse.responseBodyFunc()
                  match (mNetworkRequestStatsHandler){
                      case Some(x) => x.onResponseInputStreamError(requestStats, e)
                      case None => ()
                  }
    }