    public init(subtype: String, boundary: String, headers: HashMap<String, String>) {
        super(composeHeaders(subtype, boundary, headers))
        this.boundary = boundary
    }