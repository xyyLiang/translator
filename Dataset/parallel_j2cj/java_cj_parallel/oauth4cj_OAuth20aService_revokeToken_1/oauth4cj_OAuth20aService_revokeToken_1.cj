    public func revokeToken(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>): Unit {
        let request: OAuth4cjRequest = createRevokeTokenRequest(tokenToRevoke, tokenTypeHint)

        try (response: OAuth4cjResponse = execute(request)) {
            checkForErrorRevokeToken(response)
        }
    }