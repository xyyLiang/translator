    protected func createAccessTokenRequest(params: AccessTokenRequestParams): OAuth4cjRequest {
        let request: OAuth4cjRequest = OAuth4cjRequest(api.getAccessTokenVerb(), api.getAccessTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        request.addParameter(OAuthConstants.CODE, params.getCode())

        let callback: Option<String> = getCallback()
        match(callback) {
            case Some(v) => request.addParameter(OAuthConstants.REDIRECT_URI, v)
            case None => ()
        }

        let scope: Option<String> = params.getScope()
        match(scope) {
            case Some(v) => request.addParameter(OAuthConstants.SCOPE, v)
            case None =>
                    match(defaultScope) {
                        case Some(val) => request.addParameter(OAuthConstants.SCOPE, val)
                        case None => ()
                    }
        }
        request.addParameter(OAuthConstants.GRANT_TYPE, OAuthConstants.AUTHORIZATION_CODE)

        let pkceCodeVerifier: Option<String> = params.getPkceCodeVerifier()
        match(pkceCodeVerifier) {
            case Some(v) => request.addParameter(PKCE.PKCE_CODE_VERIFIER_PARAM, v)
            case None => ()
        }

        let extraParameters: HashMap<String, String> = params.getExtraParameters()
        if (!extraParameters.isEmpty()) {
            for ((k, v) in extraParameters) {
                request.addParameter(k, v)
            }
        }

        logRequestWithParams("access token", request)
        return request
    }