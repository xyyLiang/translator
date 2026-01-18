    public ByteArrayBodyPartPayload(byte[] payload, int off, int len, String contentType) {
        this(payload, off, len, convertContentTypeToHeaders(contentType));
    }