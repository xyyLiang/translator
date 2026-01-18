    public Future<OAuth2AccessToken> getAccessToken(AccessTokenRequestParams params,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        return sendAccessTokenRequestAsync(createAccessTokenRequest(params), callback);
    }