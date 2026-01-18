    private static Map<String, String> composeHeaders(String contentType, String name, String filename) {

        String contentDispositionHeader = "form-data";
        if (name != null) {
            contentDispositionHeader += "; name=\"" + name + '"';
        }
        if (filename != null) {
            contentDispositionHeader += "; filename=\"" + filename + '"';
        }
        if (contentType == null) {
            return Collections.singletonMap("Content-Disposition", contentDispositionHeader);
        } else {
            final Map<String, String> headers = new HashMap<>();
            headers.put(HttpClient.CONTENT_TYPE, contentType);
            headers.put("Content-Disposition", contentDispositionHeader);
            return headers;
        }
    }