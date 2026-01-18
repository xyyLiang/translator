    public func getAccessTokenClientCredentialsGrant(): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenClientCredentialsGrantRequest(None)

        return sendAccessTokenRequestSync(request)
    }