    protected void addOAuthParams(OAuthRequest request, String tokenSecret) {
        request.addOAuthParameter(OAuthConstants.TIMESTAMP, api.getTimestampService().getTimestampInSeconds());
        request.addOAuthParameter(OAuthConstants.NONCE, api.getTimestampService().getNonce());
        request.addOAuthParameter(OAuthConstants.CONSUMER_KEY, getApiKey());
        request.addOAuthParameter(OAuthConstants.SIGN_METHOD, api.getSignatureService().getSignatureMethod());
        request.addOAuthParameter(OAuthConstants.VERSION, getVersion());
        if (scope != null) {
            request.addOAuthParameter(OAuthConstants.SCOPE, scope);
        }
        request.addOAuthParameter(OAuthConstants.SIGNATURE, getSignature(request, tokenSecret));

        if (isDebug()) {
            log("appended additional OAuth parameters: %s", request.getOauthParameters());
        }
    }