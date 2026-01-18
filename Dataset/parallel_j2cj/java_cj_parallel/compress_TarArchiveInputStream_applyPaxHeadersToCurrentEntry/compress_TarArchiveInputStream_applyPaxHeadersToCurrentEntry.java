    private void applyPaxHeadersToCurrentEntry(final Map<String, String> headers, final List<TarArchiveStructSparse> sparseHeaders) throws IOException {
        currEntry.updateEntryFromPaxHeaders(headers);
        currEntry.setSparseHeaders(sparseHeaders);
    }