
    public Future<Void> revokeToken(String tokenToRevoke, OAuthAsyncRequestCallback<Void> callback,
            TokenTypeHint tokenTypeHint) {
        final OAuthRequest request = createRevokeTokenRequest(tokenToRevoke, tokenTypeHint);

        return execute(request, callback, new OAuthRequest.ResponseConverter<Void>() {
            @Override
            public Void convert(Response response) throws IOException {
                checkForErrorRevokeToken(response);
                response.close();
                return null;
            }
        });
    }