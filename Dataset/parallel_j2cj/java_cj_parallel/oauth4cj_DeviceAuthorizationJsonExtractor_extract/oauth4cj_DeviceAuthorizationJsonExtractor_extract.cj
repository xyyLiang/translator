    public func extract(response: OAuth4cjResponse): DeviceAuthorization {
        if (response.getCode() != 200) {
            generateError(response)
        }
        return createDeviceAuthorization(response.getBody())
    }