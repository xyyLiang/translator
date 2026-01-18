    public OAuth2AccessToken getAccessTokenDeviceAuthorizationGrant(DeviceAuthorization deviceAuthorization)
            throws InterruptedException, ExecutionException, IOException {
        final OAuthRequest request = createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization);

        try (Response response = execute(request)) {
            if (isDebug()) {
                log("got AccessTokenDeviceAuthorizationGrant response");
                log("response status code: %s", response.getCode());
                log("response body: %s", response.getBody());
            }
            return api.getAccessTokenExtractor().extract(response);
        }
    }