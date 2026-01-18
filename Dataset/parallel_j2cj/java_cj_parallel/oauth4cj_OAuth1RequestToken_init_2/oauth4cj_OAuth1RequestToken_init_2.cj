    public init(token: String, tokenSecret: String, oauthCallbackConfirmed: Bool, rawResponse: String) {
        super(token, tokenSecret, rawResponse)
        this.oauthCallbackConfirmed = oauthCallbackConfirmed
    }