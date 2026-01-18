    protected final static int compareUInts(int i1, int i2)
    {
        /* bit messier due to java's insistence on signed values: if both
         * have same sign, normal comparison (by subtraction) works fine;
         * but if signs don't agree need to resolve differently
         */
        if (i1 < 0) {
            return (i2 < 0) ? (i1 - i2) : 1;
        }
        return (i2 < 0) ? -1 : (i1 - i2);
    }