    public init(contentType: String, payload: Array<UInt8>, name: String) {
        this(payload, composeHeaders(contentType, name, "", filenameNull: true))
    }