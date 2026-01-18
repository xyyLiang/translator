    public func execute(userAgent: String, headers: HashMap<String, String>, httpVerb: Verb, completeUrl: String,
            bodyContents: File): OAuth4cjResponse {

        return doExecute(userAgent, headers, httpVerb, completeUrl, BodyType.FILE, bodyContents)
    }