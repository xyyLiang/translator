    protected OAuthRequest createAccessTokenDeviceAuthorizationGrantRequest(DeviceAuthorization deviceAuthorization) {
        final OAuthRequest request = new OAuthRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint());
        request.addParameter(OAuthConstants.GRANT_TYPE, "urn:ietf:params:oauth:grant-type:device_code");
        request.addParameter("device_code", deviceAuthorization.getDeviceCode());
        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret());
        return request;
    }