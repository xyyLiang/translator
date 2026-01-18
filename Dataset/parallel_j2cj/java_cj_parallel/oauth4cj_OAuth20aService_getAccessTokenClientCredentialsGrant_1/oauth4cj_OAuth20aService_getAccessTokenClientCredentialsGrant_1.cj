    public func getAccessTokenClientCredentialsGrant(scope: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(scope)

        return sendAccessTokenRequestSync(request)
    }