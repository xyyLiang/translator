    public func refreshAccessToken(refreshToken: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createRefreshTokenRequest(refreshToken, None)

        return sendAccessTokenRequestAsync(request, callback)
    }