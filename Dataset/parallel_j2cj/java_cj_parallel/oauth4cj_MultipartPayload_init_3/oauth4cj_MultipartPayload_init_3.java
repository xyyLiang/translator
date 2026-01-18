    public MultipartPayload(Map<String, String> headers) {
        this(null, parseOrGenerateBoundary(headers), headers);
    }