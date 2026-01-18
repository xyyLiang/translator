    public static int formatLongOctalBytes(final long value, final byte[] buf, final int offset, final int length) {

        final int idx = length - 1; // For space

        formatUnsignedOctalString(value, buf, offset, idx);
        buf[offset + idx] = (byte) ' '; // Trailing space

        return offset + length;
    }