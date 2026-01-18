    @Override
    public void onHttpExchangeError(RequestStats requestStats, IOException e) {
        if (Utils.isLoggingEnabled) {
            Log.d("Response Http Error :", requestStats + "");
        }

        for (OnResponseListener onResponseListener : mOnResponseListeners) {
            if (onResponseListener != null) {
                onResponseListener.onResponseError(getActiveNetworkInfo(), requestStats, e);
            }
        }
    }