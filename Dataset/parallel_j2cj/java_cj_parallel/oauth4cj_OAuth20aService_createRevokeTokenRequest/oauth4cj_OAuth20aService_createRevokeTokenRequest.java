    protected OAuthRequest createRevokeTokenRequest(String tokenToRevoke, TokenTypeHint tokenTypeHint) {
        final OAuthRequest request = new OAuthRequest(Verb.POST, api.getRevokeTokenEndpoint());

        api.getClientAuthentication().addClientAuthentication(request, getApiKey(), getApiSecret());

        request.addParameter("token", tokenToRevoke);
        if (tokenTypeHint != null) {
            request.addParameter("token_type_hint", tokenTypeHint.getValue());
        }

        logRequestWithParams("revoke token", request);

        return request;
    }