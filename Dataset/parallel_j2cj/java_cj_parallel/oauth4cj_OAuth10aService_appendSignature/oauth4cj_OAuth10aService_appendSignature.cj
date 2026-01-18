    protected func appendSignature(request: OAuth4cjRequest): Unit {
        let signatureType: OAuth1SignatureType = api.getSignatureType()
        match (signatureType) {
            case HEADER_SIGNATURE =>
                log("using Http Header signature")
                let oauthHeader: String = api.getHeaderExtractor().extract(request)
                request.addHeader(OAuthConstants.HEADER_AUTHORIZATION, oauthHeader)
            case QUERY_STRING_SIGNATURE =>
                log("using Querystring signature")
                let oauthParameters = request.getOauthParameters()
                for ((key, value) in oauthParameters) {
                    request.addQuerystringParameter(key, value)
                }
        }
    }