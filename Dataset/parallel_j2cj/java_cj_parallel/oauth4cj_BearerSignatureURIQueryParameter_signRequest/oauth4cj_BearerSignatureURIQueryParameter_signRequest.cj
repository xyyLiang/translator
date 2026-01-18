    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit {
        request.addQuerystringParameter(OAuthConstants.ACCESS_TOKEN, accessToken)
    }