    protected OAuth2AccessToken sendAccessTokenRequestSync(OAuthRequest request)
            throws IOException, InterruptedException, ExecutionException {
        if (isDebug()) {
            log("send request for access token synchronously to %s", request.getCompleteUrl());
        }
        try (Response response = execute(request)) {
            if (isDebug()) {
                log("response status code: %s", response.getCode());
                log("response body: %s", response.getBody());
            }

            return api.getAccessTokenExtractor().extract(response);
        }
    }