    protected OAuthRequest createAccessTokenPasswordGrantRequest(String username, String password, String scope) {
        final OAuthRequest request = new OAuthRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint());
        request.addParameter(OAuthConstants.USERNAME, username);
        request.addParameter(OAuthConstants.PASSWORD, password);

        if (scope != null) {
            request.addParameter(OAuthConstants.SCOPE, scope);
        } else if (defaultScope != null) {
            request.addParameter(OAuthConstants.SCOPE, defaultScope);
        }

        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.PASSWORD);

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret());

        logRequestWithParams("access token password grant", request);

        return request;
    }