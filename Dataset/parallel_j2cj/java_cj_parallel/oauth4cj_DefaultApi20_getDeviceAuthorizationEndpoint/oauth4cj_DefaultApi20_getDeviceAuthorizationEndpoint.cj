    public open func getDeviceAuthorizationEndpoint(): String {
        throw IllegalArgumentException(
            "This API doesn't support device authorization grant or we have no info about this")
    }