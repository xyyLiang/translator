    public ByteArrayBodyPartPayload(byte[] payload, int off, int len, Map<String, String> headers) {
        super(headers);
        this.payload = payload;
        this.off = off;
        this.len = len;
    }