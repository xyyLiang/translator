    private boolean ensureCache(final int count) throws IOException {
        while (bitsCachedSize < count && bitsCachedSize < 57) {
            final long nextByte = in.read();
            if (nextByte < 0) {
                return true;
            }
            if (byteOrder == ByteOrder.LITTLE_ENDIAN) {
                bitsCached |= nextByte << bitsCachedSize;
            } else {
                bitsCached <<= Byte.SIZE;
                bitsCached |= nextByte;
            }
            bitsCachedSize += Byte.SIZE;
        }
        return false;
    }