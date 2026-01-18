    public OAuth2AccessToken refreshAccessToken(String refreshToken, String scope)
            throws IOException, InterruptedException, ExecutionException {
        final OAuthRequest request = createRefreshTokenRequest(refreshToken, scope);

        return sendAccessTokenRequestSync(request);
    }