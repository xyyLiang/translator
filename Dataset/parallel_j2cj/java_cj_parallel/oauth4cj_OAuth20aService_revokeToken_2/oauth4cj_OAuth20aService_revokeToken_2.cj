    public func revokeToken(tokenToRevoke: String, callback: Option<OAuthAsyncRequestCallback>): Future<Unit> {
        return revokeToken(tokenToRevoke, callback, None)
    }