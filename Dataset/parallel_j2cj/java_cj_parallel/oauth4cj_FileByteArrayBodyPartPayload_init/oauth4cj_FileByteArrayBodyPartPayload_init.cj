    public init(payload: Array<UInt8>) {
        this(payload, composeHeaders("", "", "", contentTypeNull: true, nameNull: true, filenameNull: true))
    }