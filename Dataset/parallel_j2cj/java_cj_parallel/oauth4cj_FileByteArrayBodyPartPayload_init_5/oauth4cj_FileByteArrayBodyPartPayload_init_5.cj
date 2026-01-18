    public init(payload: Array<UInt8>, off: Int64, len: Int64, name: String, filename: String) {
        this(payload, off, len, composeHeaders("", name, filename, contentTypeNull: true))
    }