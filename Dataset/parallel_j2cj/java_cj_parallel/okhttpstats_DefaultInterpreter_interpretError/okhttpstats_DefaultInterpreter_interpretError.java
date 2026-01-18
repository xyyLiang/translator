    @Override
    public void interpretError(int requestId, NetworkInterceptor.TimeInfo timeInfo, Request request, IOException e) {
        if (Utils.isLoggingEnabled) {
            Log.d("Error response: ", e.getMessage());
        }
        final OkHttpInspectorRequest okHttpInspectorRequest = new OkHttpInspectorRequest(requestId, request.url().url(), request.method(), Utils.contentLength(request.headers()), request.header(HOST_NAME), request.body());
        mEventReporter.httpExchangeError(okHttpInspectorRequest, e);
    }