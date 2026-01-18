    public init(payload: Array<UInt8>, off: Int64, len: Int64, headers: HashMap<String, String>) {
        super(headers)
        this.payload = payload
        this.off = off
        this.len = len
    }