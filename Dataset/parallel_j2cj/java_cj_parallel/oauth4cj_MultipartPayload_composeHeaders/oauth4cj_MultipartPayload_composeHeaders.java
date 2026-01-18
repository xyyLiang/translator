    private static Map<String, String> composeHeaders(String subtype, String boundary, Map<String, String> headersIn)
            throws IllegalArgumentException {
        MultipartUtils.checkBoundarySyntax(boundary);
        final Map<String, String> headersOut;
        String contentTypeHeader = headersIn == null ? null : headersIn.get(HttpClient.CONTENT_TYPE);
        if (contentTypeHeader == null) {
            contentTypeHeader = "multipart/" + (subtype == null ? DEFAULT_SUBTYPE : subtype)
                    + "; boundary=\"" + boundary + '"';
            if (headersIn == null) {
                headersOut = Collections.singletonMap(HttpClient.CONTENT_TYPE, contentTypeHeader);
            } else {
                headersOut = headersIn;
                headersOut.put(HttpClient.CONTENT_TYPE, contentTypeHeader);
            }
        } else {
            headersOut = headersIn;
            final String parsedBoundary = MultipartUtils.parseBoundaryFromHeader(contentTypeHeader);
            if (parsedBoundary == null) {
                headersOut.put(HttpClient.CONTENT_TYPE, contentTypeHeader + "; boundary=\"" + boundary + '"');
            } else if (!parsedBoundary.equals(boundary)) {
                throw new IllegalArgumentException(
                        "Different boundaries was passed in constructors. One as argument, second as header");
            }
        }
        return headersOut;
    }