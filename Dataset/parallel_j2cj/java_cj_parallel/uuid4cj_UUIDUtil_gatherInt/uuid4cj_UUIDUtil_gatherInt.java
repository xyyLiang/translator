    private final static int _gatherInt(byte[] buffer, int offset)
    {
        return (buffer[offset] << 24) | ((buffer[offset+1] & 0xFF) << 16)
            | ((buffer[offset+2] & 0xFF) << 8) | (buffer[offset+3] & 0xFF);
    }