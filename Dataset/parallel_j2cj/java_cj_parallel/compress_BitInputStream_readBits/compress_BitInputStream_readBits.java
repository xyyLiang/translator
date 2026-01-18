    public long readBits(final int count) throws IOException {
        if (count < 0 || count > MAXIMUM_CACHE_SIZE) {
            throw new IOException("count must not be negative or greater than " + MAXIMUM_CACHE_SIZE);
        }
        if (ensureCache(count)) {
            return -1;
        }

        if (bitsCachedSize < count) {
            return processBitsGreater57(count);
        }
        return readCachedBits(count);
    }