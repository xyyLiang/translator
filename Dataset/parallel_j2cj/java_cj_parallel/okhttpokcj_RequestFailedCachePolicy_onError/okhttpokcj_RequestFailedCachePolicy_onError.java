    @Override
    public void onError(final Response<T> error) {

        if (cacheEntity != null) {
            final Response<T> cacheSuccess = Response.success(true, cacheEntity.getData(), error.getRawCall(), error.getRawResponse());
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    mCallback.onCacheSuccess(cacheSuccess);
                    mCallback.onFinish();
                }
            });
        } else {
            runOnUiThread(new Runnable() {
                @Override
                public void run() {
                    mCallback.onError(error);
                    mCallback.onFinish();
                }
            });
        }
    }