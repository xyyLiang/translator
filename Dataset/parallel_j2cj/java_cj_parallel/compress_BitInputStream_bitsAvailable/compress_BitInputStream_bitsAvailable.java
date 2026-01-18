    public long bitsAvailable() throws IOException {
        return bitsCachedSize + (long) Byte.SIZE * in.available();
    }