    protected func createDeviceAuthorizationCodesRequest(scope: Option<String>): OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, api.getDeviceAuthorizationEndpoint())
        request.addParameter(OAuthConstants.CLIENT_ID, getApiKey())

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }

        //Github's device authorization code mode can only parse JSON structures
        if (api.getAccessTokenEndpoint().contains("github") && !(responseType == "code")) {
            request.addHeader("Accept", responseType)
        }

        logRequestWithParams("Device Authorization Codes", request)

        return request
    }