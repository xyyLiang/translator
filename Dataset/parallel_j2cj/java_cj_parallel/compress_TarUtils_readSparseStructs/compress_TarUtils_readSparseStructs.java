    static List<TarArchiveStructSparse> readSparseStructs(final byte[] buffer, final int offset, final int entries) throws IOException {
        final List<TarArchiveStructSparse> sparseHeaders = new ArrayList<>();
        for (int i = 0; i < entries; i++) {
            try {
                final TarArchiveStructSparse sparseHeader = parseSparse(buffer,
                        offset + i * (TarConstants.SPARSE_OFFSET_LEN + TarConstants.SPARSE_NUMBYTES_LEN));

                if (sparseHeader.getOffset() < 0) {
                    throw new IOException("Corrupted TAR archive, sparse entry with negative offset");
                }
                if (sparseHeader.getNumbytes() < 0) {
                    throw new IOException("Corrupted TAR archive, sparse entry with negative numbytes");
                }
                sparseHeaders.add(sparseHeader);
            } catch (final IllegalArgumentException ex) {
                // thrown internally by parseOctalOrBinary
                throw new IOException("Corrupted TAR archive, sparse entry is invalid", ex);
            }
        }
        return Collections.unmodifiableList(sparseHeaders);
    }