    @Deprecated
    protected static Map<String, String> parsePaxHeaders(final InputStream inputStream, final List<TarArchiveStructSparse> sparseHeaders,
            final Map<String, String> globalPaxHeaders) throws IOException {
        return parsePaxHeaders(inputStream, sparseHeaders, globalPaxHeaders, -1);
    }