    public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64, name: String) {
        this(payload, off, len, composeHeaders(contentType, name, "", filenameNull: true))
    }