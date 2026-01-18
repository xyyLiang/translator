    public func getAccessTokenAsync(code: String): Future<OAuth2AccessToken> {
        return getAccessToken(AccessTokenRequestParams.create(code), None)
    }