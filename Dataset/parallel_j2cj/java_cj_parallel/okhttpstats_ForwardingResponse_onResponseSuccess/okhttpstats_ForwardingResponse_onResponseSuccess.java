    @Override
    public void onResponseSuccess(NetworkInfo info, RequestStats requestStats) {
        if (requestStats != null) {
            int statusCode = requestStats.statusCode;
            if ((statusCode >= HttpStatusCode.HTTP_2XX_START && statusCode <= HttpStatusCode.HTTP_2XX_END) ||
                    (statusCode >= HttpStatusCode.HTTP_3XX_START && statusCode <= HttpStatusCode.HTTP_3XX_END)) {
                mOnStatusCodeAwareResponseListener.onResponseServerSuccess(info, requestStats);
            } else if ((statusCode >= HttpStatusCode.HTTP_4XX_START && statusCode <= HttpStatusCode.HTTP_4XX_END) ||
                    (statusCode >= HttpStatusCode.HTTP_5XX_START && statusCode <= HttpStatusCode.HTTP_5XX_END)) {
                mOnStatusCodeAwareResponseListener.onResponseServerError(info, requestStats);
            }
        }
    }