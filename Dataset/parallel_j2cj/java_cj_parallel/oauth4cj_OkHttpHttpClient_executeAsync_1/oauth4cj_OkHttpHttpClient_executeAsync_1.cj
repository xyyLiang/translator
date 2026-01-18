    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
                bodyContents: MultipartPayload, callback: Option<OAuthAsyncRequestCallback>,
                converter: Option<ResponseConverter>): Future<Any> {

        throw OAuth4cjException("OKHttpClient does not support Multipart payload for the moment")
    }