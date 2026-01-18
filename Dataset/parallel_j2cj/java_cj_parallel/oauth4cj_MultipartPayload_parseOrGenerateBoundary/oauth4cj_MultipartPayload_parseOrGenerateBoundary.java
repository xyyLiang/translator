    private static String parseOrGenerateBoundary(Map<String, String> headers) {
        final String parsedBoundary = MultipartUtils.parseBoundaryFromHeader(headers.get(HttpClient.CONTENT_TYPE));
        return parsedBoundary == null ? MultipartUtils.generateDefaultBoundary() : parsedBoundary;
    }