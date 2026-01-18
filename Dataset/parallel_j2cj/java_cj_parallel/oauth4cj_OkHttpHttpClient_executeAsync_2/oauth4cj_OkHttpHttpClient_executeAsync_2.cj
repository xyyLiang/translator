    public func executeAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: String, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        return doExecuteAsync(userAgent, headers, httpVerb, completeUrl, BodyType.STRING, bodyContents, callback,
                converter)
    }