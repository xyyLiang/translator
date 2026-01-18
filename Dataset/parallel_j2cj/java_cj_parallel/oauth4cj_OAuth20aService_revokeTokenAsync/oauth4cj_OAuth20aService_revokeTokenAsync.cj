    public func revokeTokenAsync(tokenToRevoke: String): Future<Unit> {
        return revokeTokenAsync(tokenToRevoke, None)
    }