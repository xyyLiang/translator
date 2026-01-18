    @Override
    public UUID generate()
    {
        // Ok, get 60-bit timestamp (4 MSB are ignored)
        return construct(_timer.getTimestamp());
    }
    public UUID construct(long rawTimestamp)
    {
        // First: discard 4 MSB, next 32 bits (top of 60-bit timestamp) form the
        // highest 32-bit segments
        final long timestampHigh = (rawTimestamp >>> 28) << 32;
        // and then bottom 28 bits split into mid (16 bits), low (12 bits)
        final int timestampLow = (int) rawTimestamp;
        // and then low part gets mixed with variant identifier
        final int timeBottom = (((timestampLow >> 12) & 0xFFFF) << 16)
                // and final 12 bits mixed with variant identifier
                | 0x6000 | (timestampLow & 0xFFF);
        long timeBottomL = (long) timeBottom;
        timeBottomL = ((timeBottomL << 32) >>> 32); // to get rid of sign extension

        // and reconstruct
        long l1 = timestampHigh | timeBottomL;
        return new UUID(l1, _uuidL2);
    }