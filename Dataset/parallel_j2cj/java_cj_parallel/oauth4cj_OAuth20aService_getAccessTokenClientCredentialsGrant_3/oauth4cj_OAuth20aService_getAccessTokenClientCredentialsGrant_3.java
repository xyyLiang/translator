    public Future<OAuth2AccessToken> getAccessTokenClientCredentialsGrant(String scope,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        final OAuthRequest request = createAccessTokenClientCredentialsGrantRequest(scope);

        return sendAccessTokenRequestAsync(request, callback);
    }