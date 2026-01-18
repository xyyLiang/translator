    private void getAndMoveToFrontDecode() throws IOException {
        final BitInputStream bin = this.bin;
        this.origPtr = bsR(bin, 24);
        recvDecodingTables();

        final Data dataShadow = this.data;
        final byte[] ll8 = dataShadow.ll8;
        final int[] unzftab = dataShadow.unzftab;
        final byte[] selector = dataShadow.selector;
        final byte[] seqToUnseq = dataShadow.seqToUnseq;
        final char[] yy = dataShadow.getAndMoveToFrontDecode_yy;
        final int[] minLens = dataShadow.minLens;
        final int[][] limit = dataShadow.limit;
        final int[][] base = dataShadow.base;
        final int[][] perm = dataShadow.perm;
        final int limitLast = this.blockSize100k * 100000;

        /*
         * Setting up the unzftab entries here is not strictly necessary, but it does save having to do it later in a separate pass, and so saves a block's
         * worth of cache misses.
         */
        for (int i = 256; --i >= 0;) {
            yy[i] = (char) i;
            unzftab[i] = 0;
        }

        int groupNo = 0;
        int groupPos = G_SIZE - 1;
        final int eob = this.nInUse + 1;
        int nextSym = getAndMoveToFrontDecode0();
        int lastShadow = -1;
        int zt = selector[groupNo] & 0xff;
        checkBounds(zt, N_GROUPS, "zt");
        int[] base_zt = base[zt];
        int[] limit_zt = limit[zt];
        int[] perm_zt = perm[zt];
        int minLens_zt = minLens[zt];

        while (nextSym != eob) {
            if (nextSym == RUNA || nextSym == RUNB) {
                int s = -1;

                for (int n = 1; true; n <<= 1) {
                    if (nextSym == RUNA) {
                        s += n;
                    } else if (nextSym == RUNB) {
                        s += n << 1;
                    } else {
                        break;
                    }

                    if (groupPos == 0) {
                        groupPos = G_SIZE - 1;
                        checkBounds(++groupNo, MAX_SELECTORS, "groupNo");
                        zt = selector[groupNo] & 0xff;
                        checkBounds(zt, N_GROUPS, "zt");
                        base_zt = base[zt];
                        limit_zt = limit[zt];
                        perm_zt = perm[zt];
                        minLens_zt = minLens[zt];
                    } else {
                        groupPos--;
                    }

                    int zn = minLens_zt;
                    checkBounds(zn, MAX_ALPHA_SIZE, "zn");
                    int zvec = bsR(bin, zn);
                    while (zvec > limit_zt[zn]) {
                        checkBounds(++zn, MAX_ALPHA_SIZE, "zn");
                        zvec = zvec << 1 | bsR(bin, 1);
                    }
                    final int tmp = zvec - base_zt[zn];
                    checkBounds(tmp, MAX_ALPHA_SIZE, "zvec");
                    nextSym = perm_zt[tmp];
                }
                checkBounds(s, this.data.ll8.length, "s");

                final int yy0 = yy[0];
                checkBounds(yy0, 256, "yy");
                final byte ch = seqToUnseq[yy0];
                unzftab[ch & 0xff] += s + 1;

                final int from = ++lastShadow;
                lastShadow += s;
                checkBounds(lastShadow, this.data.ll8.length, "lastShadow");
                Arrays.fill(ll8, from, lastShadow + 1, ch);

                if (lastShadow >= limitLast) {
                    throw new IOException("Block overrun while expanding RLE in MTF, " + lastShadow + " exceeds " + limitLast);
                }
            } else {
                if (++lastShadow >= limitLast) {
                    throw new IOException("Block overrun in MTF, " + lastShadow + " exceeds " + limitLast);
                }
                checkBounds(nextSym, 256 + 1, "nextSym");

                final char tmp = yy[nextSym - 1];
                checkBounds(tmp, 256, "yy");
                unzftab[seqToUnseq[tmp] & 0xff]++;
                ll8[lastShadow] = seqToUnseq[tmp];

                /*
                 * This loop is hammered during decompression, hence avoid native method call overhead of System.arraycopy for very small ranges to copy.
                 */
                if (nextSym <= 16) {
                    for (int j = nextSym - 1; j > 0;) {
                        yy[j] = yy[--j];
                    }
                } else {
                    System.arraycopy(yy, 0, yy, 1, nextSym - 1);
                }

                yy[0] = tmp;

                if (groupPos == 0) {
                    groupPos = G_SIZE - 1;
                    checkBounds(++groupNo, MAX_SELECTORS, "groupNo");
                    zt = selector[groupNo] & 0xff;
                    checkBounds(zt, N_GROUPS, "zt");
                    base_zt = base[zt];
                    limit_zt = limit[zt];
                    perm_zt = perm[zt];
                    minLens_zt = minLens[zt];
                } else {
                    groupPos--;
                }

                int zn = minLens_zt;
                checkBounds(zn, MAX_ALPHA_SIZE, "zn");
                int zvec = bsR(bin, zn);
                while (zvec > limit_zt[zn]) {
                    checkBounds(++zn, MAX_ALPHA_SIZE, "zn");
                    zvec = zvec << 1 | bsR(bin, 1);
                }
                final int idx = zvec - base_zt[zn];
                checkBounds(idx, MAX_ALPHA_SIZE, "zvec");
                nextSym = perm_zt[idx];
            }
        }

        this.last = lastShadow;
    }

    private int getAndMoveToFrontDecode0() throws IOException {
        final Data dataShadow = this.data;
        final int zt = dataShadow.selector[0] & 0xff;
        checkBounds(zt, N_GROUPS, "zt");
        final int[] limit_zt = dataShadow.limit[zt];
        int zn = dataShadow.minLens[zt];
        checkBounds(zn, MAX_ALPHA_SIZE, "zn");
        int zvec = bsR(bin, zn);
        while (zvec > limit_zt[zn]) {
            checkBounds(++zn, MAX_ALPHA_SIZE, "zn");
            zvec = zvec << 1 | bsR(bin, 1);
        }
        final int tmp = zvec - dataShadow.base[zt][zn];
        checkBounds(tmp, MAX_ALPHA_SIZE, "zvec");

        return dataShadow.perm[zt][tmp];
    }
