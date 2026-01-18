    private void consumeRemainderOfLastBlock() throws IOException {
        final long bytesReadOfLastBlock = getBytesRead() % blockSize;
        if (bytesReadOfLastBlock > 0) {
            final long skipped = org.apache.commons.io.IOUtils.skip(in, blockSize - bytesReadOfLastBlock);
            count(skipped);
        }
    }