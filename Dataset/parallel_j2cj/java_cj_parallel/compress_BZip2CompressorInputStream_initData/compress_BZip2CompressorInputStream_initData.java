    private boolean init(final boolean isFirstStream) throws IOException {
        if (null == bin) {
            throw new IOException("No InputStream");
        }

        if (!isFirstStream) {
            bin.clearBitCache();
        }

        final int magic0 = readNextByte(this.bin);
        if (magic0 == -1 && !isFirstStream) {
            return false;
        }
        final int magic1 = readNextByte(this.bin);
        final int magic2 = readNextByte(this.bin);

        if (magic0 != 'B' || magic1 != 'Z' || magic2 != 'h') {
            throw new IOException(isFirstStream ? "Stream is not in the BZip2 format" : "Garbage after a valid BZip2 stream");
        }

        final int blockSize = readNextByte(this.bin);
        if (blockSize < '1' || blockSize > '9') {
            throw new IOException("BZip2 block size is invalid");
        }

        this.blockSize100k = blockSize - '0';

        this.computedCombinedCRC = 0;

        return true;
    }