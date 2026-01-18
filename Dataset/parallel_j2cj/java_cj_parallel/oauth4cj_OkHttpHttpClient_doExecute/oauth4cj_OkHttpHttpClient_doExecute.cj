    private func doExecute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyType: BodyType, bodyContents: Any): OAuth4cjResponse {
        let call: Call = createCall(userAgent, headers, httpVerb, completeUrl, bodyType, bodyContents)
        return convertResponse(call.execute())
    }