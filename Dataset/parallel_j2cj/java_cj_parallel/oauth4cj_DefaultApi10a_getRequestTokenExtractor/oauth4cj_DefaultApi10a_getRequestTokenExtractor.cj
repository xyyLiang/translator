    public open func getRequestTokenExtractor(): TokenExtractor<OAuth1RequestToken> {
        return OAuth1RequestTokenExtractor.instance()
    }