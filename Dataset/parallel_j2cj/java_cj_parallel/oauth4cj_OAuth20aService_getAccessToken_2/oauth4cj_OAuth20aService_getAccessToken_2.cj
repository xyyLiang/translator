    public func getAccessToken(params: AccessTokenRequestParams,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        return sendAccessTokenRequestAsync(createAccessTokenRequest(params), callback)
    }
