    public static boolean matches(final byte[] signature, final int length) {
        return length >= 3 && signature[0] == 'B' && signature[1] == 'Z' && signature[2] == 'h';
    }