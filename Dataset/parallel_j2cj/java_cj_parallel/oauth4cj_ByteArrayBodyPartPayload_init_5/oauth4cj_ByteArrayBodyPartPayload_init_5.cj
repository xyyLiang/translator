    public init(payload: Array<UInt8>, off: Int64, len: Int64) {
        this(payload, off, len, HashMap<String, String>())
    }