    public Future<OAuth2AccessToken> getAccessTokenClientCredentialsGrantAsync() {
        return getAccessTokenClientCredentialsGrant((OAuthAsyncRequestCallback<OAuth2AccessToken>) null);
    }