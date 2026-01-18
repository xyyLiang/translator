    public func convert(response: OAuth4cjResponse): Unit {
        if (response.getCode() != 200) {
            OAuth2AccessTokenJsonExtractor.instance().generateError(response)
        }
    }