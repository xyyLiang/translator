    public func getAccessTokenClientCredentialsGrant(scope: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(scope)

        return sendAccessTokenRequestAsync(request, callback)
    }