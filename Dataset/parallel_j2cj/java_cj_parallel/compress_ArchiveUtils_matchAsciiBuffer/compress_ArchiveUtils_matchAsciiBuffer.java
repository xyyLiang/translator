    public static boolean matchAsciiBuffer(final String expected, final byte[] buffer, final int offset, final int length) {
        final byte[] buffer1;
        buffer1 = expected.getBytes(US_ASCII);
        return isEqual(buffer1, 0, buffer1.length, buffer, offset, length, false);
    }