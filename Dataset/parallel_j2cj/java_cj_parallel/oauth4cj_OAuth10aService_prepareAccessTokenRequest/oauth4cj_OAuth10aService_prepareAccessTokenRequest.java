    protected OAuthRequest prepareAccessTokenRequest(OAuth1RequestToken requestToken, String oauthVerifier) {
        final OAuthRequest request = new OAuthRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint());
        request.addOAuthParameter(OAuthConstants.TOKEN, requestToken.getToken());
        request.addOAuthParameter(OAuthConstants.VERIFIER, oauthVerifier);
        if (isDebug()) {
            log("setting token to: %s and verifier to: %s", requestToken, oauthVerifier);
        }
        addOAuthParams(request, requestToken.getTokenSecret());
        appendSignature(request);
        return request;
    }