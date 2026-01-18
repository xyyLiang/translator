    public static UUID uuid(byte[] bytes)
    {
        _checkUUIDByteArray(bytes, 0);
        long l1 = gatherLong(bytes, 0);
        long l2 = gatherLong(bytes, 8);
        return new UUID(l1, l2);
    }