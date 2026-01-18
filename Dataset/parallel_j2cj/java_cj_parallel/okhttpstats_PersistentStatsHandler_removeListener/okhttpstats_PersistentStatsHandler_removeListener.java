    public void removeListener(OnResponseListener onResponseListener) {
        if (mOnResponseListeners != null) {
            mOnResponseListeners.remove(onResponseListener);
        }
    }
