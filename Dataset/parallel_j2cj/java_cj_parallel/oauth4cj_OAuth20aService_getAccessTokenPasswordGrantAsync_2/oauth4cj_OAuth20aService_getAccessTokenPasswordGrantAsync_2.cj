    public func getAccessTokenPasswordGrantAsync(username: String, password: String,
            callback: Option<OAuthAsyncRequestCallback>): Future<OAuth2AccessToken> {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, None)

        return sendAccessTokenRequestAsync(request, callback)
    }