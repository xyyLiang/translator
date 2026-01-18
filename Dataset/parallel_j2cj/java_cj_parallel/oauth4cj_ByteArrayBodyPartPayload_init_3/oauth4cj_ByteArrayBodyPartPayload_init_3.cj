    public init(payload: Array<UInt8>, off: Int64, len: Int64, contentType: String) {
        this(payload, off, len, convertContentTypeToHeaders(contentType))
    }