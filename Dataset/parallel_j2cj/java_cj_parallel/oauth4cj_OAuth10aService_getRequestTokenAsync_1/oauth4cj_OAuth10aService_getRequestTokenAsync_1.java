    public Future<OAuth1RequestToken> getRequestTokenAsync(OAuthAsyncRequestCallback<OAuth1RequestToken> callback) {
        if (isDebug()) {
            log("async obtaining request token from %s", api.getRequestTokenEndpoint());
        }
        final OAuthRequest request = prepareRequestTokenRequest();
        return execute(request, callback, new OAuthRequest.ResponseConverter<OAuth1RequestToken>() {
            @Override
            public OAuth1RequestToken convert(Response response) throws IOException {
                final OAuth1RequestToken token = getApi().getRequestTokenExtractor().extract(response);
                response.close();
                return token;
            }
        });
    }