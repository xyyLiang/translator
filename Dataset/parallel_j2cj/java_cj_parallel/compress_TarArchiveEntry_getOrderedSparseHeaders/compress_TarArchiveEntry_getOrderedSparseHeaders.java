    public List<TarArchiveStructSparse> getOrderedSparseHeaders() throws IOException {
        if (sparseHeaders == null || sparseHeaders.isEmpty()) {
            return Collections.emptyList();
        }
        final List<TarArchiveStructSparse> orderedAndFiltered = sparseHeaders.stream().filter(s -> s.getOffset() > 0 || s.getNumbytes() > 0)
                .sorted(Comparator.comparingLong(TarArchiveStructSparse::getOffset)).collect(Collectors.toList());

        final int numberOfHeaders = orderedAndFiltered.size();
        for (int i = 0; i < numberOfHeaders; i++) {
            final TarArchiveStructSparse str = orderedAndFiltered.get(i);
            if (i + 1 < numberOfHeaders && str.getOffset() + str.getNumbytes() > orderedAndFiltered.get(i + 1).getOffset()) {
                throw new IOException("Corrupted TAR archive. Sparse blocks for " + getName() + " overlap each other.");
            }
            if (str.getOffset() + str.getNumbytes() < 0) {
                // integer overflow?
                throw new IOException("Unreadable TAR archive. Offset and numbytes for sparse block in " + getName() + " too large.");
            }
        }
        if (!orderedAndFiltered.isEmpty()) {
            final TarArchiveStructSparse last = orderedAndFiltered.get(numberOfHeaders - 1);
            if (last.getOffset() + last.getNumbytes() > getRealSize()) {
                throw new IOException("Corrupted TAR archive. Sparse block extends beyond real size of the entry");
            }
        }

        return orderedAndFiltered;
    }
