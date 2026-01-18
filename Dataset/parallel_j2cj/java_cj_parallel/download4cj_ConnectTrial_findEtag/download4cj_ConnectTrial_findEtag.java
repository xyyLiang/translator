    @Nullable private static String findEtag(DownloadConnection.Connected connected) {
        return connected.getResponseHeaderField(ETAG);
    }