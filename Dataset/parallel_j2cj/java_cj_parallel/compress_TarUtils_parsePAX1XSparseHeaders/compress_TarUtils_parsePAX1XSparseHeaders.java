    protected static List<TarArchiveStructSparse> parsePAX1XSparseHeaders(final InputStream inputStream, final int recordSize) throws IOException {
        // for 1.X PAX Headers
        final List<TarArchiveStructSparse> sparseHeaders = new ArrayList<>();
        long bytesRead = 0;

        long[] readResult = readLineOfNumberForPax1X(inputStream);
        long sparseHeadersCount = readResult[0];
        if (sparseHeadersCount < 0) {
            // overflow while reading number?
            throw new IOException("Corrupted TAR archive. Negative value in sparse headers block");
        }
        bytesRead += readResult[1];
        while (sparseHeadersCount-- > 0) {
            readResult = readLineOfNumberForPax1X(inputStream);
            final long sparseOffset = readResult[0];
            if (sparseOffset < 0) {
                throw new IOException("Corrupted TAR archive." + " Sparse header block offset contains negative value");
            }
            bytesRead += readResult[1];

            readResult = readLineOfNumberForPax1X(inputStream);
            final long sparseNumbytes = readResult[0];
            if (sparseNumbytes < 0) {
                throw new IOException("Corrupted TAR archive." + " Sparse header block numbytes contains negative value");
            }
            bytesRead += readResult[1];
            sparseHeaders.add(new TarArchiveStructSparse(sparseOffset, sparseNumbytes));
        }

        // skip the rest of this record data
        final long bytesToSkip = recordSize - bytesRead % recordSize;
        org.apache.commons.io.IOUtils.skip(inputStream, bytesToSkip);
        return sparseHeaders;
    }
