    public static boolean matches(final byte[] signature, final int length) {
        return length > 3 && signature[0] == MAGIC_1
                && (signature[1] == (byte) MAGIC_2a || signature[1] == (byte) MAGIC_2b || signature[1] == (byte) MAGIC_2c || signature[1] == (byte) MAGIC_2d);
    }