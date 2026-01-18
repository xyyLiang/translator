    public OAuth2AccessToken getAccessTokenClientCredentialsGrant(String scope)
            throws IOException, InterruptedException, ExecutionException {
        final OAuthRequest request = createAccessTokenClientCredentialsGrantRequest(scope);

        return sendAccessTokenRequestSync(request);
    }