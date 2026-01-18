    public BodyPartPayload(String contentType) {
        this(convertContentTypeToHeaders(contentType));
    }