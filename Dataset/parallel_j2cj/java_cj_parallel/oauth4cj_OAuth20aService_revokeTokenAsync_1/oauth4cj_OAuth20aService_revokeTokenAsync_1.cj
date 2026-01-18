    public func revokeTokenAsync(tokenToRevoke: String, tokenTypeHint: Option<TokenTypeHint>): Future<Unit> {
        return revokeToken(tokenToRevoke, None, tokenTypeHint)
    }