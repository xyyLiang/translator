    public static int formatCheckSumOctalBytes(final long value, final byte[] buf, final int offset, final int length) {

        int idx = length - 2; // for NUL and space
        formatUnsignedOctalString(value, buf, offset, idx);

        buf[offset + idx++] = 0; // Trailing null
        buf[offset + idx] = (byte) ' '; // Trailing space

        return offset + length;
    }