    public func signRequest(accessToken: OAuth2AccessToken, request: OAuth4cjRequest): Unit {
        signRequest(accessToken.getAccessToken(), request)
    }