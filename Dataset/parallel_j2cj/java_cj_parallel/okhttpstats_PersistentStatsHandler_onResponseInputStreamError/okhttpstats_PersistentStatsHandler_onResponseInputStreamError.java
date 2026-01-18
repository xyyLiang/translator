    @Override
    public void onResponseInputStreamError(RequestStats requestStats, Exception e) {
        if (Utils.isLoggingEnabled) {
            Log.d("Response InputStream : ", requestStats + "");
        }

        for (OnResponseListener onResponseListener : mOnResponseListeners) {
            if (onResponseListener != null) {
                onResponseListener.onResponseError(getActiveNetworkInfo(), requestStats, e);
            }
        }
    }