    public OAuth1AccessToken getAccessToken(OAuth1RequestToken requestToken, String oauthVerifier)
            throws IOException, InterruptedException, ExecutionException {
        if (isDebug()) {
            log("obtaining access token from %s", api.getAccessTokenEndpoint());
        }
        final OAuthRequest request = prepareAccessTokenRequest(requestToken, oauthVerifier);
        try ( Response response = execute(request)) {
            return api.getAccessTokenExtractor().extract(response);
        }
    }