    public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String) {
        this(payload, off, len, composeHeaders("", name, "", contentTypeNull: true, filenameNull: true))
    }