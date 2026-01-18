    public static UUID uuid(byte[] bytes, int offset)
    {
        _checkUUIDByteArray(bytes, offset);
        return new UUID(gatherLong(bytes, offset), gatherLong(bytes, offset+8));
    }