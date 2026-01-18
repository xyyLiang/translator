    public func refreshAccessTokenAsync(refreshToken: String, scope: String): Future<OAuth2AccessToken> {
        return refreshAccessToken(refreshToken, scope, None)
    }