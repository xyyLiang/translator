    private void fswap(final int[] fmap, final int zz1, final int zz2) {
        final int zztmp = fmap[zz1];
        fmap[zz1] = fmap[zz2];
        fmap[zz2] = zztmp;
    }