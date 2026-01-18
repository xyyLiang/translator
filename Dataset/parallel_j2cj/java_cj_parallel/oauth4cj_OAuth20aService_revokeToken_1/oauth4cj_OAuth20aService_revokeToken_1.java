    public void revokeToken(String tokenToRevoke, TokenTypeHint tokenTypeHint)
            throws IOException, InterruptedException, ExecutionException {
        final OAuthRequest request = createRevokeTokenRequest(tokenToRevoke, tokenTypeHint);

        try (Response response = execute(request)) {
            checkForErrorRevokeToken(response);
        }
    }