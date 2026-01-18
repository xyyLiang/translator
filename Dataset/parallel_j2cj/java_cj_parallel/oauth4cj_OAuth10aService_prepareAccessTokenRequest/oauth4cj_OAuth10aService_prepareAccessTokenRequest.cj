    protected func prepareAccessTokenRequest(requestToken: OAuth1RequestToken, oauthVerifier: String): 
        OAuth4cjRequest {
        var request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())
        request.addOAuthParameter(OAuthConstants.TOKEN, requestToken.getToken())
        request.addOAuthParameter(OAuthConstants.VERIFIER, oauthVerifier)
        if (isDebug()) {
            let logMessages = Array<String>([requestToken.getToken(), oauthVerifier])
            log("setting token to: %s and verifier to: ", logMessages)
        }
        addOAuthParams(request, requestToken.getTokenSecret())
        appendSignature(request)
        return request
    }