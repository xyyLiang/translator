    private static func getClient(config: HttpClientConfig, provider: HttpClientProvider): Option<HttpClient> {
        return provider.createClient(config)
    }