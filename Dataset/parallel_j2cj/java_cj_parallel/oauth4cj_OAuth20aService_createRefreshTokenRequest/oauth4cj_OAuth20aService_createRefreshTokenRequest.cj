    protected func createRefreshTokenRequest(refreshToken: String, scope: Option<String>): OAuth4cjRequest {
        if (refreshToken.isEmpty()) {
            throw IllegalArgumentException("The refreshToken cannot be null or empty")
        }
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getRefreshTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }

        request.addParameter(OAuthConstants.REFRESH_TOKEN, refreshToken)
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.REFRESH_TOKEN)

        logRequestWithParams("refresh token", request)

        return request
    }