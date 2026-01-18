    public static String parseBoundaryFromHeader(String contentTypeHeader) {
        if (contentTypeHeader == null) {
            return null;
        }
        final Matcher matcher = BOUNDARY_FROM_HEADER_REGEXP.matcher(contentTypeHeader);
        return matcher.find() ? matcher.group(1) : null;
    }