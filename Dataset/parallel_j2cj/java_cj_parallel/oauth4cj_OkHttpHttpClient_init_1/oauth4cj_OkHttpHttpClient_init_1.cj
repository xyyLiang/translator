    public init(config: OkHttpHttpClientConfig) {
        let clientBuilder: HttpClientBuilder = config.getClientBuilder()
        this.client = clientBuilder.build()
    }