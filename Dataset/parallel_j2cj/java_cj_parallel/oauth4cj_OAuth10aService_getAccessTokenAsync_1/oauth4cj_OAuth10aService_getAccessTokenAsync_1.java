    public Future<OAuth1AccessToken> getAccessTokenAsync(OAuth1RequestToken requestToken, String oauthVerifier,
            OAuthAsyncRequestCallback<OAuth1AccessToken> callback) {
        if (isDebug()) {
            log("async obtaining access token from %s", api.getAccessTokenEndpoint());
        }
        final OAuthRequest request = prepareAccessTokenRequest(requestToken, oauthVerifier);
        return execute(request, callback, new OAuthRequest.ResponseConverter<OAuth1AccessToken>() {
            @Override
            public OAuth1AccessToken convert(Response response) throws IOException {
                final OAuth1AccessToken token = getApi().getAccessTokenExtractor().extract(response);
                response.close();
                return token;
            }
        });
    }