    private long processBitsGreater57(final int count) throws IOException {
        final long bitsOut;
        final int overflowBits;
        long overflow = 0L;

        // bitsCachedSize >= 57 and left-shifting it 8 bits would cause an overflow
        final int bitsToAddCount = count - bitsCachedSize;
        overflowBits = Byte.SIZE - bitsToAddCount;
        final long nextByte = in.read();
        if (nextByte < 0) {
            return nextByte;
        }
        if (byteOrder == ByteOrder.LITTLE_ENDIAN) {
            final long bitsToAdd = nextByte & MASKS[bitsToAddCount];
            bitsCached |= bitsToAdd << bitsCachedSize;
            overflow = nextByte >>> bitsToAddCount & MASKS[overflowBits];
        } else {
            bitsCached <<= bitsToAddCount;
            final long bitsToAdd = nextByte >>> overflowBits & MASKS[bitsToAddCount];
            bitsCached |= bitsToAdd;
            overflow = nextByte & MASKS[overflowBits];
        }
        bitsOut = bitsCached & MASKS[count];
        bitsCached = overflow;
        bitsCachedSize = overflowBits;
        return bitsOut;
    }