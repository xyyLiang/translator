    private static void vswap(final int[] fmap, int p1, int p2, int n) {
        n += p1;
        while (p1 < n) {
            final int t = fmap[p1];
            fmap[p1++] = fmap[p2];
            fmap[p2++] = t;
        }
    }