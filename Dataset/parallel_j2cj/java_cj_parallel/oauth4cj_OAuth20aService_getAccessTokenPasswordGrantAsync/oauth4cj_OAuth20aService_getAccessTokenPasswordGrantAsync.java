    public Future<OAuth2AccessToken> getAccessTokenPasswordGrantAsync(String username, String password) {
        return getAccessTokenPasswordGrantAsync(username, password,
                (OAuthAsyncRequestCallback<OAuth2AccessToken>) null);
    }