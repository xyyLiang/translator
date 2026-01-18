    protected func prepareRequestTokenRequest(): OAuth4cjRequest {
        var request: OAuth4cjRequest = OAuth4cjRequest(api.getRequestTokenVerb(), api.getRequestTokenEndpoint())

        let callback: String = getCallback() ?? OAuthConstants.OOB

        if (isDebug()) {
            log("setting oauth_callback to ${callback}")
        }
        request.addOAuthParameter(OAuthConstants.CALLBACK, callback)
        addOAuthParams(request, "")
        appendSignature(request)
        return request
    }