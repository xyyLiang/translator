    public func extract(request: OAuth4cjRequest): String {
        checkPreconditions(request)
        let verb: String = OAuthEncoder.encode(getVerb(request))
        let url: String = OAuthEncoder.encode(getUrl(request))
        let params: String = getSortedAndEncodedParams(request)
        return verb + "&" + url + "&" +params
    }