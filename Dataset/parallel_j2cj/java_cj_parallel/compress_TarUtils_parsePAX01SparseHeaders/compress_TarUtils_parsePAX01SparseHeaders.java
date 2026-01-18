    @Deprecated
    protected static List<TarArchiveStructSparse> parsePAX01SparseHeaders(final String sparseMap) {
        try {
            return parseFromPAX01SparseHeaders(sparseMap);
        } catch (final IOException ex) {
            throw new UncheckedIOException(ex.getMessage(), ex);
        }
    }