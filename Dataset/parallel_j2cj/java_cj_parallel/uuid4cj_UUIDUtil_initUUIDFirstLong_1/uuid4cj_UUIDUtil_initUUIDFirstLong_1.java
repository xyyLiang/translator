    public static long initUUIDFirstLong(long l1, int rawType)
    {
        l1 &= ~0xF000L; // remove high nibble of 6th byte
        l1 |= (long) (rawType << 12);
        return l1;
    }