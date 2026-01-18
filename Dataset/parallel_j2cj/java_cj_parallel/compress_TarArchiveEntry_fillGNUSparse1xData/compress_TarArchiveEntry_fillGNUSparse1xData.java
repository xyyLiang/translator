    void fillGNUSparse1xData(final Map<String, String> headers) throws IOException {
        paxGNUSparse = true;
        paxGNU1XSparse = true;
        if (headers.containsKey(TarGnuSparseKeys.NAME)) {
            name = headers.get(TarGnuSparseKeys.NAME);
        }
        if (headers.containsKey(TarGnuSparseKeys.REALSIZE)) {
            realSize = ParsingUtils.parseIntValue(headers.get(TarGnuSparseKeys.REALSIZE));
        }
    }