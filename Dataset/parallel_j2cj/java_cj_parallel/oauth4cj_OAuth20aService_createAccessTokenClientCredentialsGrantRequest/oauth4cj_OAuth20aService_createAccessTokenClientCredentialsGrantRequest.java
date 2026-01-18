    protected OAuthRequest createAccessTokenClientCredentialsGrantRequest(String scope) {
        final OAuthRequest request = new OAuthRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint());

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret());

        if (scope != null) {
            request.addParameter(OAuthConstants.SCOPE, scope);
        } else if (defaultScope != null) {
            request.addParameter(OAuthConstants.SCOPE, defaultScope);
        }
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.CLIENT_CREDENTIALS);

        logRequestWithParams("access token client credentials grant", request);

        return request;
    }