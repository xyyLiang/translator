    @Override
    public HttpClient createClient(HttpClientConfig config) {
        if (config instanceof OkHttpHttpClientConfig) {
            return new OkHttpHttpClient((OkHttpHttpClientConfig) config);
        }
        return null;
    }