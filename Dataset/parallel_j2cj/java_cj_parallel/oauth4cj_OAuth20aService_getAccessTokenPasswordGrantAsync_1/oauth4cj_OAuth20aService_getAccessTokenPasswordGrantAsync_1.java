    public Future<OAuth2AccessToken> getAccessTokenPasswordGrantAsync(String username, String password, String scope) {
        return getAccessTokenPasswordGrantAsync(username, password, scope, null);
    }