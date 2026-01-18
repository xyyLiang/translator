    public func getAccessTokenDeviceAuthorizationGrant(deviceAuthorization: DeviceAuthorization): OAuth2AccessToken {
        let request: OAuth4cjRequest = createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization)

        let response: OAuth4cjResponse = execute(request)
        if (isDebug()) {
            log("got AccessTokenDeviceAuthorizationGrant response")
            log("response status code: ${response.getCode()}")
            log("response body: ${response.getBody()}")
        }
        return api.getAccessTokenExtractor().extract(response)
    }