    void fillStarSparseData(final Map<String, String> headers) throws IOException {
        starSparse = true;
        if (headers.containsKey("SCHILY.realsize")) {
            realSize = ParsingUtils.parseLongValue(headers.get("SCHILY.realsize"));
        }
    }