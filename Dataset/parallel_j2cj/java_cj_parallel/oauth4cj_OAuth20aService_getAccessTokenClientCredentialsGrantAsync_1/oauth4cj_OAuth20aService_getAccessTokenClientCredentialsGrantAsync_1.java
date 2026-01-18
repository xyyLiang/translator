    public Future<OAuth2AccessToken> getAccessTokenClientCredentialsGrantAsync(String scope) {
        return getAccessTokenClientCredentialsGrant(scope, null);
    }