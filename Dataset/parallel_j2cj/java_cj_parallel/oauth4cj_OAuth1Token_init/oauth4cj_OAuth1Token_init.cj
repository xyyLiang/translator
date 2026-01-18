    public init(token: String, tokenSecret: String, rawResponse: String) {
        super(rawResponse)
        this.token = token
        this.tokenSecret = tokenSecret
    }