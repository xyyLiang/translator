    protected Future<OAuth2AccessToken> sendAccessTokenRequestAsync(OAuthRequest request,
            OAuthAsyncRequestCallback<OAuth2AccessToken> callback) {
        if (isDebug()) {
            log("send request for access token asynchronously to %s", request.getCompleteUrl());
        }

        return execute(request, callback, new OAuthRequest.ResponseConverter<OAuth2AccessToken>() {
            @Override
            public OAuth2AccessToken convert(Response response) throws IOException {
                log("received response for access token");
                if (isDebug()) {
                    log("response status code: %s", response.getCode());
                    log("response body: %s", response.getBody());
                }
                final OAuth2AccessToken token = api.getAccessTokenExtractor().extract(response);
                response.close();
                return token;
            }
        });
    }