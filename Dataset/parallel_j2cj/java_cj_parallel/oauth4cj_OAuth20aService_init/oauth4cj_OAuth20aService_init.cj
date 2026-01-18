    public init(api: DefaultApi20, apiKey: String, apiSecret: String, callbackUrl: Option<String>, defaultScope: Option<String>,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>) {
        super(apiKey, apiSecret, callbackUrl, debugStream, userAgent, httpClientConfig, httpClient, httpClientProvider)
        this.responseType = responseType
        this.api = api
        this.defaultScope = defaultScope
    }