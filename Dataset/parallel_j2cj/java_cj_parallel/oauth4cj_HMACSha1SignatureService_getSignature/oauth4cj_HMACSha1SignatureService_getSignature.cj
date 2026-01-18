    public func getSignature(baseString: String, apiSecret: String, tokenSecret: String): String {
        try {
            Preconditions.checkEmptyString(baseString, "Base string can't be null or empty string")
            return doSign(baseString, OAuthEncoder.encode(apiSecret) + "&" + OAuthEncoder.encode(tokenSecret))
        } catch (e: Exception) {
            throw OAuth4cjSignatureException(e.message)
        }
    }