    public func getAccessTokenDeviceAuthorizationGrantAsync(
            deviceAuthorization: DeviceAuthorization): Future<OAuth2AccessToken> {
        return getAccessTokenDeviceAuthorizationGrant(deviceAuthorization, None)
    }