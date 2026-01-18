    public OAuth2AccessToken getAccessToken(AccessTokenRequestParams params)
            throws IOException, InterruptedException, ExecutionException {
        return sendAccessTokenRequestSync(createAccessTokenRequest(params));
    }