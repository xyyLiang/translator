    public ByteArrayBodyPartPayload(byte[] payload, String contentType) {
        this(payload, convertContentTypeToHeaders(contentType));
    }