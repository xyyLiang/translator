    public OAuthService(String apiKey, String apiSecret, String callback, OutputStream debugStream,
            String userAgent, HttpClientConfig httpClientConfig, HttpClient httpClient) {
        this.apiKey = apiKey;
        this.apiSecret = apiSecret;
        this.callback = callback;
        this.debugStream = debugStream;
        this.userAgent = userAgent;

        if (httpClientConfig == null && httpClient == null) {
            this.httpClient = new JDKHttpClient(JDKHttpClientConfig.defaultConfig());
        } else {
            this.httpClient = httpClient == null ? getClient(httpClientConfig) : httpClient;
        }
    }