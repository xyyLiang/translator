    public Future<OAuth2AccessToken> refreshAccessToken(String refreshToken,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        final OAuthRequest request = createRefreshTokenRequest(refreshToken, null);

        return sendAccessTokenRequestAsync(request, callback);
    }