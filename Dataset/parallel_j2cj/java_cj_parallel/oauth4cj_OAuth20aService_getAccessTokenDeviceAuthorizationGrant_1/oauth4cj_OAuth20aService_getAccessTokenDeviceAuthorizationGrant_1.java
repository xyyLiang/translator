    public Future<OAuth2AccessToken> getAccessTokenDeviceAuthorizationGrant(DeviceAuthorization deviceAuthorization,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        final OAuthRequest request = createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization);

        return execute(request, callback, new OAuthRequest.ResponseConverter<OAuth2AccessToken>() {
            @Override
            public OAuth2AccessToken convert(Response response) throws IOException {
                final OAuth2AccessToken accessToken = api.getAccessTokenExtractor().extract(response);
                response.close();
                return accessToken;
            }
        });
    }