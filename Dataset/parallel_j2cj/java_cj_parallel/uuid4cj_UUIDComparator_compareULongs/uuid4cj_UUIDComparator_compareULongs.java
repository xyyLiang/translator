    protected final static int compareULongs(long l1, long l2) {
        int diff = compareUInts((int) (l1 >> 32), (int) (l2 >> 32));
        if (diff == 0) {
            diff = compareUInts((int) l1, (int) l2);
        }
        return diff;
    }