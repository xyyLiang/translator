    public init(api: DefaultApi10a, apiKey: String, apiSecret: String, callbackUrl: Option<String>, scope: Option<String>,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>, httpClientProvider: Option<HttpClientProvider>) {
        super(apiKey, apiSecret, callbackUrl, debugStream, userAgent, httpClientConfig, httpClient, httpClientProvider)
        this.api = api
        this.scope = scope
    }