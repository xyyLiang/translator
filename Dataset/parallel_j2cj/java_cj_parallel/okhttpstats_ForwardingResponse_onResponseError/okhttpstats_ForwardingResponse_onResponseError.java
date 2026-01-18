    @Override
    public void onResponseError(NetworkInfo info, RequestStats requestStats, Exception e) {
        mOnStatusCodeAwareResponseListener.onResponseNetworkError(info, requestStats, e);
    }