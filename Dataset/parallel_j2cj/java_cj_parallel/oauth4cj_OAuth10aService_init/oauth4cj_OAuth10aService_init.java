    public OAuth10aService(DefaultApi10a api, String apiKey, String apiSecret, String callback, String scope,
            OutputStream debugStream, String userAgent, HttpClientConfig httpClientConfig, HttpClient httpClient) {
        super(apiKey, apiSecret, callback, debugStream, userAgent, httpClientConfig, httpClient);
        this.api = api;
        this.scope = scope;
    }