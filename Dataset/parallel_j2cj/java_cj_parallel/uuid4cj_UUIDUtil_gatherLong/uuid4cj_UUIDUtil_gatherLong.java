    protected final static long gatherLong(byte[] buffer, int offset)
    {
        long hi = ((long) _gatherInt(buffer, offset)) << 32;
        //long lo = ((long) _gatherInt(buffer, offset+4)) & MASK_LOW_INT;
        long lo = (((long) _gatherInt(buffer, offset+4)) << 32) >>> 32;
        return hi | lo;
    }