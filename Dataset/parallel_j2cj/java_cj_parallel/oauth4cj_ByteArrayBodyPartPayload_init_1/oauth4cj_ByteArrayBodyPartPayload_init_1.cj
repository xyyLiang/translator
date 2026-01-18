    public init(payload: Array<UInt8>, headers: HashMap<String, String>) {
        this(payload, 0, payload.size, headers)
    }