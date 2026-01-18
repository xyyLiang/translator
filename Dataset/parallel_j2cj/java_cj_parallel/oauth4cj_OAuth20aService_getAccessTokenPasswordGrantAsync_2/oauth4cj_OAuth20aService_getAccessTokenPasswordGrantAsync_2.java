    public Future<OAuth2AccessToken> getAccessTokenPasswordGrantAsync(String username, String password,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        final OAuthRequest request = createAccessTokenPasswordGrantRequest(username, password, null);

        return sendAccessTokenRequestAsync(request, callback);
    }