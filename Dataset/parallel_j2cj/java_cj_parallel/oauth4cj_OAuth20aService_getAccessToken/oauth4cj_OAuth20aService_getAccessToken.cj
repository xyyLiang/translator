    public func getAccessToken(code: String): OAuth2AccessToken {
        return getAccessToken(AccessTokenRequestParams.create(code))
    }
