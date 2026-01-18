    public Future<OAuth2AccessToken> refreshAccessTokenAsync(String refreshToken, String scope) {
        return refreshAccessToken(refreshToken, scope, null);
    }