    public static void inspectUserHeader(@NonNull Map<String, List<String>> headerField)
            throws IOException {
        if (headerField.containsKey(IF_MATCH) || headerField.containsKey(RANGE)) {
            throw new IOException(IF_MATCH + " and " + RANGE + " only can be handle by internal!");
        }
    }