    public ByteArrayBodyPartPayload(byte[] payload, Map<String, String> headers) {
        this(payload, 0, payload.length, headers);
    }