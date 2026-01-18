    public void signRequest(OAuth1AccessToken token, OAuthRequest request) {
        if (isDebug()) {
            log("signing request: %s", request.getCompleteUrl());
        }

        if (!token.isEmpty() || api.isEmptyOAuthTokenParamIsRequired()) {
            request.addOAuthParameter(OAuthConstants.TOKEN, token.getToken());
        }
        if (isDebug()) {
            log("setting token to: %s", token);
        }
        addOAuthParams(request, token.getTokenSecret());
        appendSignature(request);
    }