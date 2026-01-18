    protected OAuthRequest prepareRequestTokenRequest() {
        final OAuthRequest request = new OAuthRequest(api.getRequestTokenVerb(), api.getRequestTokenEndpoint());
        String callback = getCallback();
        if (callback == null) {
            callback = OAuthConstants.OOB;
        }
        if (isDebug()) {
            log("setting oauth_callback to %s", callback);
        }
        request.addOAuthParameter(OAuthConstants.CALLBACK, callback);
        addOAuthParams(request, "");
        appendSignature(request);
        return request;
    }