    public open func getAuthorizationUrl(requestToken: OAuth1RequestToken): String {
        let parameters: ParameterList = ParameterList()
        parameters.add(OAuthConstants.TOKEN, requestToken.getToken())
        return parameters.appendTo(getAuthorizationBaseUrl())
    }