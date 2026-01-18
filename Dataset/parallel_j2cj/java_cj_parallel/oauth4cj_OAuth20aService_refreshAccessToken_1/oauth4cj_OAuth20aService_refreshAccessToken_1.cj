    public func refreshAccessToken(refreshToken: String, scope: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createRefreshTokenRequest(refreshToken, scope)

        return sendAccessTokenRequestSync(request)
    }