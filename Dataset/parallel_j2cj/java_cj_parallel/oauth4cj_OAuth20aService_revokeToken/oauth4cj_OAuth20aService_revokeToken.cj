    public func revokeToken(tokenToRevoke: String): Unit {
        revokeToken(tokenToRevoke, Option<TokenTypeHint>.None)
    }