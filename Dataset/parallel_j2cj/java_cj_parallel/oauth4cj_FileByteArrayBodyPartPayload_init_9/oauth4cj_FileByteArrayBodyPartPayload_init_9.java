    public FileByteArrayBodyPartPayload(String contentType, byte[] payload, int off, int len, String name) {
        this(contentType, payload, off, len, name, null);
    }