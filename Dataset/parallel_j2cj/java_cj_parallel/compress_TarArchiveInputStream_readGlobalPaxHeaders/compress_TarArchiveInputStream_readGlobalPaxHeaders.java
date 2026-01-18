    private void readGlobalPaxHeaders() throws IOException {
        globalPaxHeaders = TarUtils.parsePaxHeaders(this, globalSparseHeaders, globalPaxHeaders, entrySize);
        getNextEntry(); // Get the actual file entry

        if (currEntry == null) {
            throw new IOException("Error detected parsing the pax header");
        }
    }