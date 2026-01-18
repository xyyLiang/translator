    public func createService(apiKey:String, apiSecret: String, callbackUrl: Option<String>, scope: Option<String>,
            debugStream: Option<OutputStream>, userAgent: String, httpClientConfig: Option<HttpClientConfig>,
            httpClient: Option<HttpClient>, httpClientProvider: Option<HttpClientProvider>): OAuth10aService {
        return OAuth10aService(this, apiKey, apiSecret, callbackUrl, scope, debugStream, userAgent,
            httpClientConfig, httpClient, httpClientProvider)
    }