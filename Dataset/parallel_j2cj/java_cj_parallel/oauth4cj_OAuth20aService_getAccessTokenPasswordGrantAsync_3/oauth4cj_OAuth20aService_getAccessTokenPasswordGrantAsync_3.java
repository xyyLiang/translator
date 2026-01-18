    public Future<OAuth2AccessToken> getAccessTokenPasswordGrantAsync(String username, String password, String scope,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        final OAuthRequest request = createAccessTokenPasswordGrantRequest(username, password, scope);

        return sendAccessTokenRequestAsync(request, callback);
    }