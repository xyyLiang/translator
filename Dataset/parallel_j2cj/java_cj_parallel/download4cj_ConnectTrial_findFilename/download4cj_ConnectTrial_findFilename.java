    @Nullable private static String findFilename(DownloadConnection.Connected connected)
        throws IOException {
        return parseContentDisposition(connected.getResponseHeaderField(CONTENT_DISPOSITION));
    }