    public OAuth2AccessToken getAccessToken(String code) throws IOException, InterruptedException, ExecutionException {
        return getAccessToken(AccessTokenRequestParams.create(code));
    }