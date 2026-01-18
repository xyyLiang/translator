    private final static void _checkUUIDByteArray(byte[] bytes, int offset)
    {
        if (bytes == null) {
            throw new IllegalArgumentException("Invalid byte[] passed: can not be null");
        }
        if (offset < 0) {
            throw new IllegalArgumentException("Invalid offset ("+offset+") passed: can not be negative");
        }
        if ((offset + 16) > bytes.length) {
            throw new IllegalArgumentException("Invalid offset ("+offset+") passed: not enough room in byte array (need 16 bytes)");
        }
    }