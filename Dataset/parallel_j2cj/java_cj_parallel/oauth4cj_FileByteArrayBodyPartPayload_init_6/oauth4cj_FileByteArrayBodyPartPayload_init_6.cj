    public init(contentType: String, payload: Array<UInt8>) {
        this(payload, composeHeaders(contentType, "", "", nameNull: true, filenameNull: true))
    }