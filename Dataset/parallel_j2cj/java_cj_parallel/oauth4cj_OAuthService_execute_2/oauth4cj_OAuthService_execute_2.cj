    public func execute(request: OAuth4cjRequest): OAuth4cjResponse {
        let filePayload: Option<File> = request.getFilePayload()
        let stringPayload: String = request.getStringPayload()
        let multipartPayload: Option<MultipartPayload> = request.getMultipartPayload()

        var hasFile: Bool = false
        match (filePayload) {
            case None => hasFile = false
            case Some(data) => hasFile = true
        }

        var hasMultipart: Bool = false
        match (multipartPayload) {
            case None => hasMultipart = false
            case Some(data) => hasMultipart = true
        }

        if (hasFile) {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), filePayload.getOrThrow().readToEnd())
        } else if (!stringPayload.isEmpty()) {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), stringPayload.toArray())
        } else if (hasMultipart) {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), multipartPayload.getOrThrow())
        } else {
            return httpClient.getOrThrow().execute(userAgent, request.getHeaders(), request.getVerb(),
                request.getCompleteUrl(), request.getByteArrayPayload())
        }
    }