    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, scope)

        return sendAccessTokenRequestAsync(request, callback)
    }