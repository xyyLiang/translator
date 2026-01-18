    void fillGNUSparse0xData(final Map<String, String> headers) throws IOException {
        paxGNUSparse = true;
        realSize = ParsingUtils.parseIntValue(headers.get(TarGnuSparseKeys.SIZE));
        if (headers.containsKey(TarGnuSparseKeys.NAME)) {
            // version 0.1
            name = headers.get(TarGnuSparseKeys.NAME);
        }
    }