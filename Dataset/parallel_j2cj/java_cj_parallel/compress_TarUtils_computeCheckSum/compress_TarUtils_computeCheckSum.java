    public static long computeCheckSum(final byte[] buf) {
        long sum = 0;

        for (final byte element : buf) {
            sum += BYTE_MASK & element;
        }

        return sum;
    }