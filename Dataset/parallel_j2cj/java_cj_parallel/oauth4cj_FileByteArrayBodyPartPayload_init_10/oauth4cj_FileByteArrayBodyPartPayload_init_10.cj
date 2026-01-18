    public init(contentType: String, payload: Array<UInt8>, name: String, filename: String) {
        super(payload, composeHeaders(contentType, name, filename))
    }