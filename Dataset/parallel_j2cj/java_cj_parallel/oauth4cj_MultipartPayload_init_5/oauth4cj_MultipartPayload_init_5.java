    public MultipartPayload(String subtype, String boundary, Map<String, String> headers) {
        super(composeHeaders(subtype, boundary, headers));
        this.boundary = boundary;
    }