    public static void addUserRequestHeaderField(@NonNull Map<String, List<String>> userHeaderField,
                                                 @NonNull DownloadConnection connection)
            throws IOException {
        inspectUserHeader(userHeaderField);
        addRequestHeaderFields(userHeaderField, connection);
    }