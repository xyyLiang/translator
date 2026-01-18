    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit {
        request.addHeader(OAuthConstants.HEADER_AUTHORIZATION, "Bearer ${accessToken}")
    }