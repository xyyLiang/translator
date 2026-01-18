    public init(contentType: String) {
        this.headers = convertContentTypeToHeaders(contentType)
    }