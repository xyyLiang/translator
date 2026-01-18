    public init(contentType: String, payload: Array<UInt8>, off: Int64, len: Int64) {
        this(payload, off, len, composeHeaders(contentType, "", "", nameNull: true, filenameNull: true))
    }