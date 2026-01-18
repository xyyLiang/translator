    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: MultipartPayload): OAuth4cjResponse {

        throw OAuth4cjException("OKHttpClient does not support Multipart payload for the moment")
    }