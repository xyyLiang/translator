    public static long initUUIDSecondLong(long l2)
    {
        l2 = ((l2 << 2) >>> 2); // remove 2 MSB
        l2 |= (2L << 62); // set 2 MSB to '10'
        return l2;
    }