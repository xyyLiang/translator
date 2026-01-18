    public OAuth2AccessToken getAccessTokenPasswordGrant(String username, String password, String scope)
            throws IOException, InterruptedException, ExecutionException {
        final OAuthRequest request = createAccessTokenPasswordGrantRequest(username, password, scope);

        return sendAccessTokenRequestSync(request);
    }