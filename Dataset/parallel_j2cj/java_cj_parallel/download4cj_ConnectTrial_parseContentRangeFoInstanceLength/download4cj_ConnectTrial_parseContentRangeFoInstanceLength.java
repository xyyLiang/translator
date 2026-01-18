    private static long parseContentRangeFoInstanceLength(@Nullable String contentRange) {
        if (contentRange == null) return CHUNKED_CONTENT_LENGTH;

        final String[] session = contentRange.split("/");
        if (session.length >= 2) {
            try {
                return Long.parseLong(session[1]);
            } catch (NumberFormatException e) {
                Util.w(TAG, "parse instance length failed with " + contentRange);
            }
        }

        return -1;
    }