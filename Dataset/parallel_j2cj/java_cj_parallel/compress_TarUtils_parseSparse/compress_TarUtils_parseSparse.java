    public static TarArchiveStructSparse parseSparse(final byte[] buffer, final int offset) {
        final long sparseOffset = parseOctalOrBinary(buffer, offset, TarConstants.SPARSE_OFFSET_LEN);
        final long sparseNumbytes = parseOctalOrBinary(buffer, offset + TarConstants.SPARSE_OFFSET_LEN, TarConstants.SPARSE_NUMBYTES_LEN);

        return new TarArchiveStructSparse(sparseOffset, sparseNumbytes);
    }