    public OAuth20Service(DefaultApi20 api, String apiKey, String apiSecret, String callback, String defaultScope,
            String responseType, OutputStream debugStream, String userAgent, HttpClientConfig httpClientConfig,
            HttpClient httpClient) {
        super(apiKey, apiSecret, callback, debugStream, userAgent, httpClientConfig, httpClient);
        this.responseType = responseType;
        this.api = api;
        this.defaultScope = defaultScope;
    }