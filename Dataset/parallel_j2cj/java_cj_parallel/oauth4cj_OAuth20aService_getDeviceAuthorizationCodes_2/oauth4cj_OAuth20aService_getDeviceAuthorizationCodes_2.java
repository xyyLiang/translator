    public Future<DeviceAuthorization> getDeviceAuthorizationCodes(
            OAuthAsyncRequestCallback<DeviceAuthorization> callback) {
        return getDeviceAuthorizationCodes(null, callback);
    }