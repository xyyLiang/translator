    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        try {
            return OAuthEncoder.encode(apiSecret) + "&" + OAuthEncoder.encode(tokenSecret)
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(e.message)
        }
    }