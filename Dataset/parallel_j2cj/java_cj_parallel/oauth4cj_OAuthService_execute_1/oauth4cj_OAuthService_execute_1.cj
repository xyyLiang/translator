    public func execute(request: OAuth4cjRequest, callback: Option<OAuthAsyncRequestCallback>,
            converter: Option<ResponseConverter>): Future<Any> {

        let filePayload: Option<File> = request.getFilePayload()
        let stringPayload: String = request.getStringPayload()

        var hasFile: Bool = false
        match (filePayload) {
            case None => hasFile = false
            case Some(data) => hasFile = true
        }

        if (hasFile) {
            return httpClient.getOrThrow().executeAsync(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), filePayload.getOrThrow().readToEnd(), callback, converter)
        } else if (!stringPayload.isEmpty()) {
            return httpClient.getOrThrow().executeAsync(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), stringPayload.toArray(), callback, converter)
        } else {
            return httpClient.getOrThrow().executeAsync(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), request.getByteArrayPayload(), callback, converter)
        }
    }