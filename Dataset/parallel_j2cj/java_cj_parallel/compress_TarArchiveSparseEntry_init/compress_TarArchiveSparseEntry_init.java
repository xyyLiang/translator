    public TarArchiveSparseEntry(final byte[] headerBuf) throws IOException {
        int offset = 0;
        sparseHeaders = new ArrayList<>(TarUtils.readSparseStructs(headerBuf, 0, SPARSE_HEADERS_IN_EXTENSION_HEADER));
        offset += SPARSELEN_GNU_SPARSE;
        isExtended = TarUtils.parseBoolean(headerBuf, offset);
    }