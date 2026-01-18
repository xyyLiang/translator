    public func refreshAccessToken(refreshToken: String, scope: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createRefreshTokenRequest(refreshToken, scope)

        return sendAccessTokenRequestAsync(request, callback)
    }