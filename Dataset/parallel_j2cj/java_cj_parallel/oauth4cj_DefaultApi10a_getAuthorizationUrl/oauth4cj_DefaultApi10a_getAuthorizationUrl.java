    public String getAuthorizationUrl(OAuth1RequestToken requestToken) {
        final ParameterList parameters = new ParameterList();
        parameters.add(OAuthConstants.TOKEN, requestToken.getToken());
        return parameters.appendTo(getAuthorizationBaseUrl());
    }