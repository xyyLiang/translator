    @NonNull public synchronized DownloadConnection getConnectionOrCreate() throws IOException {
        if (cache.isInterrupt()) throw InterruptException.SIGNAL;

        if (connection == null) {
            final String url;
            final String redirectLocation = cache.getRedirectLocation();
            if (redirectLocation != null) {
                url = redirectLocation;
            } else {
                url = info.getUrl();
            }

            Util.d(TAG, "create connection on url: " + url);

            connection = OkDownload.with().connectionFactory().create(url);
        }
        return connection;
    }