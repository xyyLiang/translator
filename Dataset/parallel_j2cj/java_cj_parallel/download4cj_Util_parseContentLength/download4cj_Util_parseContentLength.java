    public static long parseContentLength(@Nullable String contentLength) {
        if (contentLength == null) return CHUNKED_CONTENT_LENGTH;

        try {
            return Long.parseLong(contentLength);
        } catch (NumberFormatException ignored) {
            Util.d("Util", "parseContentLength failed parse for '" + contentLength + "'");
        }

        return CHUNKED_CONTENT_LENGTH;
    }