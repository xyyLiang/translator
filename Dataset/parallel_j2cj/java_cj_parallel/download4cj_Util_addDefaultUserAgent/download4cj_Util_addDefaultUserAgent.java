    public static void addDefaultUserAgent(@NonNull final DownloadConnection connection) {
        final String userAgent = "OkDownload/" + BuildConfig.VERSION_NAME;
        connection.addHeader(USER_AGENT, userAgent);
    }