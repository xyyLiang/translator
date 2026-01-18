    @Override
    public Response intercept(Chain chain) throws IOException {
        final int requestId = mNextRequestId.getAndIncrement();
        Request request = chain.request();
        TimeInfo timeInfo = new TimeInfo();
        Response response;
        try {
            //note the time taken for the response
            timeInfo.mStartTime = System.currentTimeMillis();
            response = chain.proceed(request);
            timeInfo.mEndTime = System.currentTimeMillis();
        } catch (final IOException e) {
            if (mEnabled) {
                //notify event reporter in case there is any exception while proceeding request
                mInterpreter.interpretError(requestId, timeInfo, request, e);
            }
            throw e;
        }

        if (mEnabled) {
            response = mInterpreter.interpretResponseStream(requestId, timeInfo, request, response);
        }

        return response;
    }
