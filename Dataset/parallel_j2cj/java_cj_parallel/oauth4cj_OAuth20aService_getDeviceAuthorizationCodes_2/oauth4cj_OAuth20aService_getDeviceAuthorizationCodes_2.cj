    public func getDeviceAuthorizationCodes(
            callback: Option<OAuthAsyncRequestCallback>): Future<DeviceAuthorization> {
        return getDeviceAuthorizationCodes(Option<String>.None, callback)
    }