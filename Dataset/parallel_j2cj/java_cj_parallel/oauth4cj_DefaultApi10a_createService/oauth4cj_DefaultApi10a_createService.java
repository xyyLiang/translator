    public OAuth10aService createService(String apiKey, String apiSecret, String callback, String scope,
            OutputStream debugStream, String userAgent, HttpClientConfig httpClientConfig, HttpClient httpClient) {
        return new OAuth10aService(this, apiKey, apiSecret, callback, scope, debugStream, userAgent, httpClientConfig,
                httpClient);
    }