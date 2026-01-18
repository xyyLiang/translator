    protected func addOAuthParams(request: OAuth4cjRequest, tokenSecret: String): Unit {
        request.addOAuthParameter(OAuthConstants.TIMESTAMP, api.getTimestampService().getTimestampInSeconds())
        request.addOAuthParameter(OAuthConstants.NONCE, api.getTimestampService().getNonce())
        request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, getApiKey())
        request.addOAuthParameter(OAuthConstants.SIGN_METHOD, api.getSignatureService().getSignatureMethod())
        request.addOAuthParameter(OAuthConstants.VERSION, getVersion())
        match(scope) {
            case Some(v) => request.addOAuthParameter(OAuthConstants.SCOPE, v)
            case None => ()
        }

        request.addOAuthParameter(OAuthConstants.SIGNATURE, getSignature(request, tokenSecret))
        if (isDebug()) {
            log("appended additional OAuth parameters: ${request.getOauthParameters()}")
        }
    }