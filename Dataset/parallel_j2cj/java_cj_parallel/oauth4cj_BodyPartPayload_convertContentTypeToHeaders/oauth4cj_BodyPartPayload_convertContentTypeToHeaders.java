    protected static Map<String, String> convertContentTypeToHeaders(String contentType) {
        return contentType == null ? null : Collections.singletonMap(HttpClient.CONTENT_TYPE, contentType);
    }