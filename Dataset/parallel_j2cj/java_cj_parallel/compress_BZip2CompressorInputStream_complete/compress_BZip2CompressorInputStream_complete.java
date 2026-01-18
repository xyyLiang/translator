    private boolean complete() throws IOException {
        this.storedCombinedCRC = bsGetInt(bin);
        this.currentState = EOF;
        this.data = null;

        if (this.storedCombinedCRC != this.computedCombinedCRC) {
            throw new IOException("BZip2 CRC error");
        }

        // Look for the next .bz2 stream if decompressing
        // concatenated files.
        return !decompressConcatenated || !init(false);
    }