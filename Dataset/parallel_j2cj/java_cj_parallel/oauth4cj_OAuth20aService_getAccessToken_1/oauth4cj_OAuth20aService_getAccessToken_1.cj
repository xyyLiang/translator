    public func getAccessToken(params: AccessTokenRequestParams): OAuth2AccessToken {
        return sendAccessTokenRequestSync(createAccessTokenRequest(params))
    }