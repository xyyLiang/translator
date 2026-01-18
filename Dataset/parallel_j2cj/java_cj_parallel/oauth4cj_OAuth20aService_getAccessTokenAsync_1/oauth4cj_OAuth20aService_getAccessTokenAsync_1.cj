    public func getAccessTokenAsync(params: AccessTokenRequestParams): Future<OAuth2AccessToken> {
        return getAccessToken(params, None)
    }