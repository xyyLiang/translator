    public func refreshAccessTokenAsync(refreshToken: String): Future<OAuth2AccessToken> {
        return refreshAccessToken(refreshToken, Option<OAuthAsyncRequestCallback>.None)
    }