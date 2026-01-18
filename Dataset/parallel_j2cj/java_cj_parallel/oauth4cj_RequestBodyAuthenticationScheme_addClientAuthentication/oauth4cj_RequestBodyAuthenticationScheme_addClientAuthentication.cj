    public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit {
        request.addParameter(OAuthConstants.CLIENT_ID, apiKey)
        request.addParameter(OAuthConstants.CLIENT_SECRET, apiSecret)
    }