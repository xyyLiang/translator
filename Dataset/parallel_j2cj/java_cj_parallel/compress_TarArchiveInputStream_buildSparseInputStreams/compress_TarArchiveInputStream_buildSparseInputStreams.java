    private void buildSparseInputStreams() throws IOException {
        currentSparseInputStreamIndex = -1;
        sparseInputStreams = new ArrayList<>();

        final List<TarArchiveStructSparse> sparseHeaders = currEntry.getOrderedSparseHeaders();

        // Stream doesn't need to be closed at all as it doesn't use any resources
        final InputStream zeroInputStream = new TarArchiveSparseZeroInputStream(); // NOSONAR
        // logical offset into the extracted entry
        long offset = 0;
        for (final TarArchiveStructSparse sparseHeader : sparseHeaders) {
            final long zeroBlockSize = sparseHeader.getOffset() - offset;
            if (zeroBlockSize < 0) {
                // sparse header says to move backwards inside the extracted entry
                throw new IOException("Corrupted struct sparse detected");
            }

            // only store the zero block if it is not empty
            if (zeroBlockSize > 0) {
                sparseInputStreams.add(new BoundedInputStream(zeroInputStream, sparseHeader.getOffset() - offset));
            }

            // only store the input streams with non-zero size
            if (sparseHeader.getNumbytes() > 0) {
                sparseInputStreams.add(new BoundedInputStream(in, sparseHeader.getNumbytes()));
            }

            offset = sparseHeader.getOffset() + sparseHeader.getNumbytes();
        }

        if (!sparseInputStreams.isEmpty()) {
            currentSparseInputStreamIndex = 0;
        }
    }
