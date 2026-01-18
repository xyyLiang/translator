    public init(accessToken: String, tokenType: String, expiresIn: Int32, refreshToken: String, scope: String,
            rawResponse: String) {
        super(rawResponse)
        if (expiresIn < 0) {
            throw OAuth4cjException("The effective time cannot be negative")
        }
        this.accessToken = accessToken
        this.tokenType = tokenType
        this.expiresIn = expiresIn
        this.refreshToken = refreshToken
        this.scope = scope
    }