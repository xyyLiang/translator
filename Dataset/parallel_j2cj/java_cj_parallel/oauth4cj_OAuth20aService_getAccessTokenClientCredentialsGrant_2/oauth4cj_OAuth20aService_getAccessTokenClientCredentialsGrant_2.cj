    public func getAccessTokenClientCredentialsGrant(
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(None)

        return sendAccessTokenRequestAsync(request, callback)
    }