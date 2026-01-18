    public init(payload: Array<UInt8>, name: String, filename: String) {
        this(payload, composeHeaders("", name, filename, contentTypeNull: true))
    }