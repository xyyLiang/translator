    public static void addRequestHeaderFields(
            @NonNull Map<String, List<String>> headerFields,
            @NonNull DownloadConnection connection) {
        for (Map.Entry<String, List<String>> entry : headerFields.entrySet()) {
            String key = entry.getKey();
            List<String> values = entry.getValue();
            for (String value : values) {
                connection.addHeader(key, value);
            }
        }
    }