    public func getDeviceAuthorizationCodes(scope: Option<String>): DeviceAuthorization {
        let request: OAuth4cjRequest = createDeviceAuthorizationCodesRequest(scope)

        let response: OAuth4cjResponse = execute(request)
        if (isDebug()) {
            log("got DeviceAuthorizationCodes response")
            log("response status code: ${response.getCode()}")
            log("response body: ${response.getBody()}")
        }
        return api.getDeviceAuthorizationExtractor().extract(response)
    }