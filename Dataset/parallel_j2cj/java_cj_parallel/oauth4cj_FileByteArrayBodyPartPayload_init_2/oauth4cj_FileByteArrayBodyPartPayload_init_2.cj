    public init(payload: Array<UInt8>, name: String) {
        this(payload, composeHeaders("", name, "", contentTypeNull: true, filenameNull: true))
    }