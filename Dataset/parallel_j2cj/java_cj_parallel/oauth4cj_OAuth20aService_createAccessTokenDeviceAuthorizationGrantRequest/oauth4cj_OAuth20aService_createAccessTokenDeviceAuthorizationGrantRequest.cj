    protected func createAccessTokenDeviceAuthorizationGrantRequest(deviceAuthorization: DeviceAuthorization):
                    OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())

        if (api.getAccessTokenEndpoint().contains("huawei")) {//for huawei
            request.addParameter(OAuthConstants.GRANT_TYPE, "device_code")
            request.addParameter("code", deviceAuthorization.getDeviceCode())
        } else {
            request.addParameter(OAuthConstants.GRANT_TYPE, "urn:ietf:params:oauth:grant-type:device_code")
            request.addParameter("device_code", deviceAuthorization.getDeviceCode())
        }

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())
        return request
    }