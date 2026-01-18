    private int fill(final byte value, final int offset, final byte[] outbuf, final int length) {
        for (int i = 0; i < length; i++) {
            outbuf[offset + i] = value;
        }
        return offset + length;
    }