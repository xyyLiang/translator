    public Future<OAuth2AccessToken> refreshAccessToken(String refreshToken, String scope,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        final OAuthRequest request = createRefreshTokenRequest(refreshToken, scope);

        return sendAccessTokenRequestAsync(request, callback);
    }