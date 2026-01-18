    public func getAccessTokenPasswordGrant(username: String, password: String, scope: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, scope)

        return sendAccessTokenRequestSync(request)
    }