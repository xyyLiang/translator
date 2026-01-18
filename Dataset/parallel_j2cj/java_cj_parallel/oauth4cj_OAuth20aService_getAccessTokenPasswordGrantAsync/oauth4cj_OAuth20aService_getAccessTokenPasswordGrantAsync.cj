    public func getAccessTokenPasswordGrantAsync(username: String, password: String): Future<OAuth2AccessToken> {
        return getAccessTokenPasswordGrantAsync(username, password, None)
    }