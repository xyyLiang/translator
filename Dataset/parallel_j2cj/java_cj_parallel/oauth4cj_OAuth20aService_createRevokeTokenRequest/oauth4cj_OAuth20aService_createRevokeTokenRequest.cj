    protected func createRevokeTokenRequest(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>):
                        OAuth4cjRequest {

        let request: OAuth4cjRequest = OAuth4cjRequest(Verb.POST, api.getRevokeTokenEndpoint())

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret())

        //The field name supported by Weibo is access_token
        if (api.getAccessTokenEndpoint().contains("weibo")) {
            request.addParameter("access_token", tokenToRevoke)
        } else {
            request.addParameter("token", tokenToRevoke)
        }

        match(tokenTypeHint) {
            case Some(v) => request.addParameter("token_type_hint", v.getValue())
            case None => ()
        }

        logRequestWithParams("revoke token", request)

        return request
    }