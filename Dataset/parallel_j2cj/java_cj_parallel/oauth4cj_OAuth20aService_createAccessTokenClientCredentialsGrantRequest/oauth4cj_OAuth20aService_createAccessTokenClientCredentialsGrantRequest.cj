    protected func createAccessTokenClientCredentialsGrantRequest(scope: Option<String>): OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.CLIENT_CREDENTIALS)

        logRequestWithParams("access token client credentials grant", request)

        return request
    }