    public void addListener(OnResponseListener onResponseListener) {
        if (mOnResponseListeners != null) {
            mOnResponseListeners.add(onResponseListener);
        }
    }