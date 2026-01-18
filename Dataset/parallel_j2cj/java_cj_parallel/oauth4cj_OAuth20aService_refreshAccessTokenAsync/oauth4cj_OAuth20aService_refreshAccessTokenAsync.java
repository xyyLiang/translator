    public Future<OAuth2AccessToken> refreshAccessTokenAsync(String refreshToken) {
        return refreshAccessToken(refreshToken, (OAuthAsyncRequestCallback<OAuth2AccessToken>) null);
    }