    public OAuth2AccessToken getAccessTokenClientCredentialsGrant()
            throws IOException, InterruptedException, ExecutionException {
        final OAuthRequest request = createAccessTokenClientCredentialsGrantRequest(null);

        return sendAccessTokenRequestSync(request);
    }