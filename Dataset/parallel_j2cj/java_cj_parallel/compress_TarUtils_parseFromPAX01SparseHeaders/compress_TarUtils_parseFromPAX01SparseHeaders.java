    protected static List<TarArchiveStructSparse> parseFromPAX01SparseHeaders(final String sparseMap) throws IOException {
        final List<TarArchiveStructSparse> sparseHeaders = new ArrayList<>();
        final String[] sparseHeaderStrings = sparseMap.split(",");
        if (sparseHeaderStrings.length % 2 == 1) {
            throw new IOException("Corrupted TAR archive. Bad format in GNU.sparse.map PAX Header");
        }

        for (int i = 0; i < sparseHeaderStrings.length; i += 2) {
            final long sparseOffset = ParsingUtils.parseLongValue(sparseHeaderStrings[i]);
            if (sparseOffset < 0) {
                throw new IOException("Corrupted TAR archive." + " Sparse struct offset contains negative value");
            }
            final long sparseNumbytes = ParsingUtils.parseLongValue(sparseHeaderStrings[i + 1]);
            if (sparseNumbytes < 0) {
                throw new IOException("Corrupted TAR archive." + " Sparse struct numbytes contains negative value");
            }
            sparseHeaders.add(new TarArchiveStructSparse(sparseOffset, sparseNumbytes));
        }

        return Collections.unmodifiableList(sparseHeaders);
    }