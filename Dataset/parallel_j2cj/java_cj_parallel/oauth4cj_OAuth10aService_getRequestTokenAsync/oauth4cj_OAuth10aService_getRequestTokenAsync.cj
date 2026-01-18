    public func getRequestTokenAsync(): Future<OAuth1RequestToken> {
        return getRequestTokenAsync(Option<OAuthAsyncRequestCallback>.None)
    }