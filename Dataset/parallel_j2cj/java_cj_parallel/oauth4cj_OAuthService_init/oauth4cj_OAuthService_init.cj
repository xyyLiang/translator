    public init(apiKey: String, apiSecret: String, callbackUrl: Option<String>, debugStream: Option<OutputStream>,
            userAgent: String, httpClientConfig: Option<HttpClientConfig>, httpClient: Option<HttpClient>,
            httpClientProvider: Option<HttpClientProvider>) {
        this.apiKey = apiKey
        this.apiSecret = apiSecret
        this.callbackUrl = callbackUrl
        this.debugStream = debugStream
        this.userAgent = userAgent

        match (httpClient) {
            case None => hasClient = false
            case Some(data) => hasClient = true
        }

        match (httpClientConfig) {
            case None => hasConfig = false
            case Some(data) => hasConfig = true
        }

        match (httpClientProvider) {
            case None => hasProvider = false
            case Some(data) => hasProvider = true
        }

        if (hasClient) {
            this.httpClient = httpClient
        } else if (hasConfig && hasProvider) {
            this.httpClient = getClient(httpClientConfig.getOrThrow(), httpClientProvider.getOrThrow())
        } else if (hasConfig && !hasProvider) {
            this.httpClient = Option<HttpClient>.None
        } else {
            this.httpClient = Some(OkHttpHttpClient(OkHttpHttpClientConfig.defaultConfig()))
        }
    }