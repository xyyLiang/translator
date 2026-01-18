    @Override
    public Response interpretResponseStream(int requestId, NetworkInterceptor.TimeInfo timeInfo, Request request, Response response) {
        ResponseBody responseBody = response.body();

        final OkHttpInspectorRequest okHttpInspectorRequest = new OkHttpInspectorRequest(requestId, request.url().url(), request.method(), Utils.contentLength(request.headers()), request.url().host(), request.body());
        final OkHttpInspectorResponse okHttpInspectorResponse = new OkHttpInspectorResponse(requestId, response.code(), Utils.contentLength(response.headers()), timeInfo.mStartTime, timeInfo.mEndTime, responseBody);
        //if response does not have content length, using CountingInputStream to read its bytes
        if (response.header(CONTENT_LENGTH) == null) {
            InputStream responseStream = null;
            if (responseBody != null) {
                try {
                    responseStream = responseBody.byteStream();
                } catch (Exception e) {
                    if (Utils.isLoggingEnabled) {
                        Log.d("Error reading IS : ", e.getMessage());
                    }

                    //notify event reporter in case there is any exception while getting the input stream of response
                    mEventReporter.responseInputStreamError(okHttpInspectorRequest, okHttpInspectorResponse, e);
                    throw e;
                }
            }

            //interpreting the response stream using CountingInputStream, once the counting is done, notify the event reporter that response has been received
            responseStream = new CountingInputStream(responseStream, new DefaultResponseHandler(new DefaultResponseHandler.ResponseCallback() {
                @Override
                public void onEOF(long bytesRead) {
                    okHttpInspectorResponse.mResponseSize = bytesRead;
                    mEventReporter.responseReceived(okHttpInspectorRequest, okHttpInspectorResponse);
                }
            }));

            //creating response object using the interpreted stream
            response = response.newBuilder().body(new ForwardingResponseBody(responseBody, responseStream)).build();
        } else {
            //if response has content length, notify the event reporter that response has been received.
            mEventReporter.responseReceived(okHttpInspectorRequest, okHttpInspectorResponse);
        }

        return response;
    }
