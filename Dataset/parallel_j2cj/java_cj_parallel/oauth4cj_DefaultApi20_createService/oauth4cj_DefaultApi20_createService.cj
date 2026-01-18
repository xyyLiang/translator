    public open func createService(apiKey: String, apiSecret: String, callbackUrl: Option<String>, defaultScope: Option<String>,
            responseType: String, debugStream: Option<OutputStream>, userAgent: String, 
            httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>): OAuth20Service {
        return OAuth20Service(this, apiKey, apiSecret, callbackUrl, defaultScope, responseType, debugStream, userAgent,
            httpClientConfig, httpClient, httpClientProvider)
    }