    private final static void _appendInt(int value, byte[] buffer, int offset)
    {
        buffer[offset++] = (byte) (value >> 24);
        buffer[offset++] = (byte) (value >> 16);
        buffer[offset++] = (byte) (value >> 8);
        buffer[offset] = (byte) value;
    }