    public func addClientAuthentication(request: OAuth4cjRequest, apiKey: String, apiSecret: String): Unit {
        let encodeString: String = Base64Utils.encode("${apiKey}:${apiSecret}".toArray())
        request.addHeader(OAuthConstants.HEADER_AUTHORIZATION, "${OAuthConstants.BASIC} ${encodeString}")
    }