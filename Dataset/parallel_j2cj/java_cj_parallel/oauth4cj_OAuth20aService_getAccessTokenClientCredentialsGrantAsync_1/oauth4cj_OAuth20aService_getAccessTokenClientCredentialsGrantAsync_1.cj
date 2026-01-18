    public func getAccessTokenClientCredentialsGrantAsync(scope: String): Future<OAuth2AccessToken> {
        return getAccessTokenClientCredentialsGrant(scope, Option<OAuthAsyncRequestCallback>.None)
    }