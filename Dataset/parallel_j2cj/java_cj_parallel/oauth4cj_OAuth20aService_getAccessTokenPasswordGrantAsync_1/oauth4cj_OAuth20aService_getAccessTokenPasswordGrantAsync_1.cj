    public func getAccessTokenPasswordGrantAsync(username: String, password: String, scope: String):
                    Future<OAuth2AccessToken> {
        return getAccessTokenPasswordGrantAsync(username, password, scope, None)
    }