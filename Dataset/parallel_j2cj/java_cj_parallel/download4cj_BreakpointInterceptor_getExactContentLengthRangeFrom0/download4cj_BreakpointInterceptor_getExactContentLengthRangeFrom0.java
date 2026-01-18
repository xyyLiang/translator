    @IntRange(from = -1)
    long getExactContentLengthRangeFrom0(@NonNull DownloadConnection.Connected connected) {
        final String contentRangeField = connected.getResponseHeaderField(CONTENT_RANGE);
        long contentLength = -1;
        if (!Util.isEmpty(contentRangeField)) {
            final long rightRange = getRangeRightFromContentRange(contentRangeField);
            // for the range from 0, the contentLength is just right-range +1.
            if (rightRange > 0) contentLength = rightRange + 1;
        }

        if (contentLength < 0) {
            // content-length
            final String contentLengthField = connected.getResponseHeaderField(CONTENT_LENGTH);
            if (!Util.isEmpty(contentLengthField)) {
                contentLength = Long.parseLong(contentLengthField);
            }
        }

        return contentLength;
    }