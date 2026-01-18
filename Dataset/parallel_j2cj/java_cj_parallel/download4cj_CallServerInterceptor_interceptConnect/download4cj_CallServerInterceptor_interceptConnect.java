    @NonNull @Override
    public DownloadConnection.Connected interceptConnect(DownloadChain chain) throws IOException {
        OkDownload.with().downloadStrategy().inspectNetworkOnWifi(chain.getTask());
        OkDownload.with().downloadStrategy().inspectNetworkAvailable();

        return chain.getConnectionOrCreate().execute();
    }