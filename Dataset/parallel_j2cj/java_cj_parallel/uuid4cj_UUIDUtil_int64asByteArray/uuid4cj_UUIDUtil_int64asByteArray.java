    public static byte[] asByteArray(UUID uuid)
    {
        long hi = uuid.getMostSignificantBits();
        long lo = uuid.getLeastSignificantBits();
        byte[] result = new byte[16];
        _appendInt((int) (hi >> 32), result, 0);
        _appendInt((int) hi, result, 4);
        _appendInt((int) (lo >> 32), result, 8);
        _appendInt((int) lo, result, 12);
        return result;
    }