    public Future<OAuth2AccessToken> getAccessToken(String code,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        return getAccessToken(AccessTokenRequestParams.create(code), callback);
    }