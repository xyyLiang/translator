    private static long findInstanceLength(DownloadConnection.Connected connected) {
        // Content-Range
        final long instanceLength = parseContentRangeFoInstanceLength(
                connected.getResponseHeaderField(CONTENT_RANGE));
        if (instanceLength != CHUNKED_CONTENT_LENGTH) return instanceLength;

        // chunked on here
        final boolean isChunked = parseTransferEncoding(connected
                .getResponseHeaderField(TRANSFER_ENCODING));
        if (!isChunked) {
            Util.w(TAG, "Transfer-Encoding isn't chunked but there is no "
                    + "valid instance length found either!");
        }

        return CHUNKED_CONTENT_LENGTH;
    }