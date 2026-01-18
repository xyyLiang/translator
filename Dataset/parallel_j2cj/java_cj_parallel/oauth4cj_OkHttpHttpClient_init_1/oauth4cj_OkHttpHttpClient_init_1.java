    public OkHttpHttpClient(OkHttpHttpClientConfig config) {
        final OkHttpClient.Builder clientBuilder = config.getClientBuilder();
        client = clientBuilder == null ? new OkHttpClient() : clientBuilder.build();
    }