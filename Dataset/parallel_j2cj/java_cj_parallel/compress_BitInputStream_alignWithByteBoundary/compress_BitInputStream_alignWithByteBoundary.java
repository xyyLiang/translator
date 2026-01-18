    public void alignWithByteBoundary() {
        final int toSkip = bitsCachedSize % Byte.SIZE;
        if (toSkip > 0) {
            readCachedBits(toSkip);
        }
    }