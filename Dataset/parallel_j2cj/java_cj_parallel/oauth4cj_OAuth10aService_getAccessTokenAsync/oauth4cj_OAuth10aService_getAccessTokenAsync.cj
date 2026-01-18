    public func getAccessTokenAsync(requestToken: OAuth1RequestToken, oauthVerifier: String): 
        Future<OAuth1AccessToken> {
        return getAccessTokenAsync(requestToken, oauthVerifier, Option<OAuthAsyncRequestCallback>.None)
    }
