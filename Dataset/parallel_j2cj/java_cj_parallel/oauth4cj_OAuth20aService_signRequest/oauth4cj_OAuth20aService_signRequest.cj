    public func signRequest(accessToken: String, request: OAuth4cjRequest): Unit {
        api.getBearerSignature().signRequest(accessToken, request)
    }