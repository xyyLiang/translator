    private void paxHeaders() throws IOException {
        List<TarArchiveStructSparse> sparseHeaders = new ArrayList<>();
        final Map<String, String> headers = TarUtils.parsePaxHeaders(this, sparseHeaders, globalPaxHeaders, entrySize);

        // for 0.1 PAX Headers
        if (headers.containsKey(TarGnuSparseKeys.MAP)) {
            sparseHeaders = new ArrayList<>(TarUtils.parseFromPAX01SparseHeaders(headers.get(TarGnuSparseKeys.MAP)));
        }
        getNextEntry(); // Get the actual file entry
        if (currEntry == null) {
            throw new IOException("premature end of tar archive. Didn't find any entry after PAX header.");
        }
        applyPaxHeadersToCurrentEntry(headers, sparseHeaders);

        // for 1.0 PAX Format, the sparse map is stored in the file data block
        if (currEntry.isPaxGNU1XSparse()) {
            sparseHeaders = TarUtils.parsePAX1XSparseHeaders(in, recordSize);
            currEntry.setSparseHeaders(sparseHeaders);
        }

        // sparse headers are all done reading, we need to build
        // sparse input streams using these sparse headers
        buildSparseInputStreams();
    }