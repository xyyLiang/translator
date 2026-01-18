    public OAuth2AccessToken getAccessTokenPasswordGrant(String username, String password)
            throws IOException, InterruptedException, ExecutionException {
        final OAuthRequest request = createAccessTokenPasswordGrantRequest(username, password, null);

        return sendAccessTokenRequestSync(request);
    }