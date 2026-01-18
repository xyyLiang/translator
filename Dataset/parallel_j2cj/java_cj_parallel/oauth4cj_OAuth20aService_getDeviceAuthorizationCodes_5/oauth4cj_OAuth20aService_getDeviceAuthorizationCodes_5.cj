    public func getDeviceAuthorizationCodesAsync(scope: Option<String>): Future<DeviceAuthorization> {
        return getDeviceAuthorizationCodes(scope, None)
    }