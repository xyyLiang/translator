    public func signRequest(token: OAuth1AccessToken, request: OAuth4cjRequest): Unit {
        if (isDebug()) {
            log("signing request: ${request.getCompleteUrl()}")
        }

        if (!token.isEmpty() || api.isEmptyOAuthTokenParamIsRequired()) {
            request.addOAuthParameter(OAuthConstants.TOKEN, token.getToken())
        }
        if (isDebug()) {
            log("setting token to: ${token.getToken()}")
        }
        addOAuthParams(request, token.getTokenSecret())
        appendSignature(request)
    }