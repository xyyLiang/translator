    public init(headers: HashMap<String, String>) {
        this(DEFAULT_SUBTYPE, parseOrGenerateBoundary(headers), headers)
    }