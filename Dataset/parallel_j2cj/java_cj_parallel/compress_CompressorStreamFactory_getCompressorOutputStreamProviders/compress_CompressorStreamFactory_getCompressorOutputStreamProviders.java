    public SortedMap<String, CompressorStreamProvider> getCompressorOutputStreamProviders() {
        if (compressorOutputStreamProviders == null) {
            compressorOutputStreamProviders = Collections.unmodifiableSortedMap(findAvailableCompressorOutputStreamProviders());
        }
        return compressorOutputStreamProviders;
    }