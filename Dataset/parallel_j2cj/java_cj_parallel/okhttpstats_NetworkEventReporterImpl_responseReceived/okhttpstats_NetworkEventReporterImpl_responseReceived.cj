    public open func responseReceived (inspectorRequest: NetworkEventReporterInspectorRequest, inspectorResponse: NetworkEventReporterInspectorResponse): Unit {
          var requestId: Int64 = inspectorRequest.requestId()
          requestId = inspectorResponse.requestId()
          var requestStatsTmp: RequestStats = RequestStats(requestId)
          requestStatsTmp.requestSize = inspectorRequest.requestSize()
          requestStatsTmp.url = inspectorRequest.url()
          requestStatsTmp.methodType = inspectorRequest.method()
          requestStatsTmp.hostName = inspectorRequest.hostName()
          requestStatsTmp.requestBody = inspectorRequest.requestBody()
          requestStatsTmp.responseSize = inspectorResponse.responseSize()
          requestStatsTmp.statusCode = inspectorResponse.statusCode()
          requestStatsTmp.startTime = inspectorResponse.startTime()
          requestStatsTmp.endTime = inspectorResponse.endTime()
          requestStatsTmp.responseBody = inspectorResponse.responseBodyFunc()
          match (mNetworkRequestStatsHandler){
              case Some(x) => x.onResponseReceived(requestStatsTmp)
              case None => ()
          }
    }