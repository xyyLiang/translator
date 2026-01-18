    public init(payload: Array<UInt8>, contentType: String) {
        this(payload, convertContentTypeToHeaders(contentType))
    }