    private int readSparse(final byte[] buf, final int offset, final int numToRead) throws IOException {
        // if there are no actual input streams, just read from the original input stream
        if (sparseInputStreams == null || sparseInputStreams.isEmpty()) {
            return in.read(buf, offset, numToRead);
        }

        if (currentSparseInputStreamIndex >= sparseInputStreams.size()) {
            return -1;
        }

        final InputStream currentInputStream = sparseInputStreams.get(currentSparseInputStreamIndex);
        final int readLen = currentInputStream.read(buf, offset, numToRead);

        // if the current input stream is the last input stream,
        // just return the number of bytes read from current input stream
        if (currentSparseInputStreamIndex == sparseInputStreams.size() - 1) {
            return readLen;
        }

        // if EOF of current input stream is meet, open a new input stream and recursively call read
        if (readLen == -1) {
            currentSparseInputStreamIndex++;
            return readSparse(buf, offset, numToRead);
        }

        // if the rest data of current input stream is not long enough, open a new input stream
        // and recursively call read
        if (readLen < numToRead) {
            currentSparseInputStreamIndex++;
            final int readLenOfNext = readSparse(buf, offset + readLen, numToRead - readLen);
            if (readLenOfNext == -1) {
                return readLen;
            }

            return readLen + readLenOfNext;
        }

        // if the rest data of current input stream is enough(which means readLen == len), just return readLen
        return readLen;
    }
