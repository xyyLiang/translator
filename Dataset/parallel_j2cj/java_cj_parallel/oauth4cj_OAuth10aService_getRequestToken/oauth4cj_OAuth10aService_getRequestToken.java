    public OAuth1RequestToken getRequestToken() throws IOException, InterruptedException, ExecutionException {
        if (isDebug()) {
            log("obtaining request token from %s", api.getRequestTokenEndpoint());
        }
        final OAuthRequest request = prepareRequestTokenRequest();

        log("sending request...");
        try ( Response response = execute(request)) {
            if (isDebug()) {
                final String body = response.getBody();
                log("response status code: %s", response.getCode());
                log("response body: %s", body);
            }
            return api.getRequestTokenExtractor().extract(response);
        }
    }