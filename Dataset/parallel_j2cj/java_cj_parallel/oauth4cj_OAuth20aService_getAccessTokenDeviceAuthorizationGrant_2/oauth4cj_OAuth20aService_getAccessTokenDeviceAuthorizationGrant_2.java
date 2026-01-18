    public Future<OAuth2AccessToken> getAccessTokenDeviceAuthorizationGrantAsync(
            DeviceAuthorization deviceAuthorization) {
        return getAccessTokenDeviceAuthorizationGrant(deviceAuthorization, null);
    }