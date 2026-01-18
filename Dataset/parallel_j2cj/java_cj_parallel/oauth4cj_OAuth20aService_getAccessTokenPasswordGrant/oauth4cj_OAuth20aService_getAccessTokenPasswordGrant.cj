    public func getAccessTokenPasswordGrant(username: String, password: String): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenPasswordGrantRequest(username, password, None)

        return sendAccessTokenRequestSync(request)
    }