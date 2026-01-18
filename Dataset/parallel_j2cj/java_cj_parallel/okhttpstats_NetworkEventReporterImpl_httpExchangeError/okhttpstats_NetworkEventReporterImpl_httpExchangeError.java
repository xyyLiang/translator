    @Override
    public void httpExchangeError(final InspectorRequest inspectorRequest, final IOException e) {
        if (inspectorRequest != null) {
            final int requestId = inspectorRequest.requestId();
            RequestStats requestStats = new RequestStats(requestId);
            requestStats.url = inspectorRequest.url();
            requestStats.methodType = inspectorRequest.method();
            requestStats.hostName = inspectorRequest.hostName();
            requestStats.requestSize = inspectorRequest.requestSize();
            requestStats.requestBody = inspectorRequest.requestBody();
            mNetworkRequestStatsHandler.onHttpExchangeError(requestStats, e);
        }
    }