    private long readCachedBits(final int count) {
        final long bitsOut;
        if (byteOrder == ByteOrder.LITTLE_ENDIAN) {
            bitsOut = bitsCached & MASKS[count];
            bitsCached >>>= count;
        } else {
            bitsOut = bitsCached >> bitsCachedSize - count & MASKS[count];
        }
        bitsCachedSize -= count;
        return bitsOut;
    }