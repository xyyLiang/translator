    @Override
    public void responseReceived(final InspectorRequest inspectorRequest, final InspectorResponse inspectorResponse) {
        if (inspectorRequest != null && inspectorResponse != null) {
            final int requestId = inspectorResponse.requestId();
            RequestStats requestStats = new RequestStats(requestId);
            requestStats.requestSize = inspectorRequest.requestSize();
            requestStats.url = inspectorRequest.url();
            requestStats.methodType = inspectorRequest.method();
            requestStats.hostName = inspectorRequest.hostName();
            requestStats.requestBody = inspectorRequest.requestBody();
            requestStats.responseSize = inspectorResponse.responseSize();
            requestStats.statusCode = inspectorResponse.statusCode();
            requestStats.startTime = inspectorResponse.startTime();
            requestStats.endTime = inspectorResponse.endTime();
            requestStats.responseBody = inspectorResponse.responseBody();
            mNetworkRequestStatsHandler.onResponseReceived(requestStats);
        }
    }