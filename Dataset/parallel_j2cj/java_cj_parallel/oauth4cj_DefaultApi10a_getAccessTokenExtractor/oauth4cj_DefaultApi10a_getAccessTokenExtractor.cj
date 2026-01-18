    public open func getAccessTokenExtractor(): TokenExtractor<OAuth1AccessToken> {
        return OAuth1AccessTokenExtractor.instance()
    }