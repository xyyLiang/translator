    public func getAccessTokenClientCredentialsGrantAsync(): Future<OAuth2AccessToken> {
        return getAccessTokenClientCredentialsGrant(Option<OAuthAsyncRequestCallback>.None)
    }