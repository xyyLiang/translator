    public open func getAuthorizationUrl(responseType: String, apiKey: String, callback: ?String, scope: ?String,
            state: ?String, additionalParams: HashMap<String, String>): String {
        let parameters: ParameterList = ParameterList(additionalParams)
        parameters.add(OAuthConstants.RESPONSE_TYPE, responseType)
        parameters.add(OAuthConstants.CLIENT_ID, apiKey)

        match(callback) {
             case Some(x) => parameters.add(OAuthConstants.REDIRECT_URI, x)
             case _ => ()
        }
        match(scope) {
             case Some(x) => parameters.add(OAuthConstants.SCOPE, x)
             case _ => ()
        }
        match(state) {
             case Some(x) => parameters.add(OAuthConstants.STATE, x)
             case _ => ()
        }
        return parameters.appendTo(getAuthorizationBaseUrl())
    }