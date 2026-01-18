    protected func createAccessTokenPasswordGrantRequest(username: String, password: String, scope: Option<String>):
                    OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())
        request.addParameter(OAuthConstants.USERNAME, username)
        request.addParameter(OAuthConstants.PASSWORD, password)

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }

        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.PASSWORD)

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        logRequestWithParams("access token password grant", request)

        return request
    }