    public void execute(Callback<T> callback) {
        HttpUtils.checkNotNull(callback, "callback == null");

        this.callback = callback;
        Call<T> call = adapt();
        call.execute(callback);
    }