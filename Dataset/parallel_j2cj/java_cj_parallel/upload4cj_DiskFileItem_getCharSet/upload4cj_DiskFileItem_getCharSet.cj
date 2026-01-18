    public func getCharSet(): String {
        var parse: ParameterParser = ParameterParser()
        parse.setLowerCaseNames(true)
        let params: Map<String, Option<String>> = parse.parse(this.getContentType(), ';')
        return params.get("charset").getOrThrow().getOrThrow()
    }