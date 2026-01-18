    public func getAccessToken(code: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        return getAccessToken(AccessTokenRequestParams.create(code), callback)
    }