    protected OAuthRequest createDeviceAuthorizationCodesRequest(String scope) {
        final OAuthRequest request = new OAuthRequest(Verb.POST, api.getDeviceAuthorizationEndpoint());
        request.addParameter(OAuthConstants.CLIENT_ID, getApiKey());
        if (scope != null) {
            request.addParameter(OAuthConstants.SCOPE, scope);
        } else if (defaultScope != null) {
            request.addParameter(OAuthConstants.SCOPE, defaultScope);
        }

        logRequestWithParams("Device Authorization Codes", request);

        return request;
    }