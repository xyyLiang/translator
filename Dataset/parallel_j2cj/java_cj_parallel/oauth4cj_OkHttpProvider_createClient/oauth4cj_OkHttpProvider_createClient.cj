    public func createClient(config: HttpClientConfig): Option<HttpClient> {
        if (config is OkHttpHttpClientConfig) {
            return OkHttpHttpClient((config as OkHttpHttpClientConfig).getOrThrow())
        }
        return None
    }