    private static boolean isAcceptRange(@NonNull DownloadConnection.Connected connected)
            throws IOException {
        if (connected.getResponseCode() == HttpURLConnection.HTTP_PARTIAL) return true;

        final String acceptRanges = connected.getResponseHeaderField(ACCEPT_RANGES);
        return "bytes".equals(acceptRanges);
    }