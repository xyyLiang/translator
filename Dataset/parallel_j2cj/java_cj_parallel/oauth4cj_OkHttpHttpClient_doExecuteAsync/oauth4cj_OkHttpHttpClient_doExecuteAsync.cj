    private func doExecuteAsync(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb,
            completeUrl: String, bodyType: BodyType, bodyContents: Any, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {
        let call: Call = createCall(userAgent, headers, httpVerb, completeUrl, bodyType, bodyContents)

        let oach: OAuthAsyncCompletionHandler = OAuthAsyncCompletionHandler(callback, converter)
        call.enqueue(oach)
        return oach.getFuture()
    }