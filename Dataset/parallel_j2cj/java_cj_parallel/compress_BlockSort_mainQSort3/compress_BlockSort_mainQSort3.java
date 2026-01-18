    private void mainQSort3(final BZip2CompressorOutputStream.Data dataShadow, final int loSt, final int hiSt, final int dSt, final int last) {
        final int[] stack_ll = this.stack_ll;
        final int[] stack_hh = this.stack_hh;
        final int[] stack_dd = this.stack_dd;
        final int[] fmap = dataShadow.fmap;
        final byte[] block = dataShadow.block;

        stack_ll[0] = loSt;
        stack_hh[0] = hiSt;
        stack_dd[0] = dSt;

        for (int sp = 1; --sp >= 0;) {
            final int lo = stack_ll[sp];
            final int hi = stack_hh[sp];
            final int d = stack_dd[sp];

            if (hi - lo < SMALL_THRESH || d > DEPTH_THRESH) {
                if (mainSimpleSort(dataShadow, lo, hi, d, last)) {
                    return;
                }
            } else {
                final int d1 = d + 1;
                final int med = med3(block[fmap[lo] + d1] & 0xff, block[fmap[hi] + d1] & 0xff, block[fmap[lo + hi >>> 1] + d1] & 0xff);

                int unLo = lo;
                int unHi = hi;
                int ltLo = lo;
                int gtHi = hi;

                while (true) {
                    while (unLo <= unHi) {
                        final int n = (block[fmap[unLo] + d1] & 0xff) - med;
                        if (n == 0) {
                            final int temp = fmap[unLo];
                            fmap[unLo++] = fmap[ltLo];
                            fmap[ltLo++] = temp;
                        } else if (n < 0) {
                            unLo++;
                        } else {
                            break;
                        }
                    }

                    while (unLo <= unHi) {
                        final int n = (block[fmap[unHi] + d1] & 0xff) - med;
                        if (n == 0) {
                            final int temp = fmap[unHi];
                            fmap[unHi--] = fmap[gtHi];
                            fmap[gtHi--] = temp;
                        } else if (n > 0) {
                            unHi--;
                        } else {
                            break;
                        }
                    }

                    if (unLo > unHi) {
                        break;
                    }
                    final int temp = fmap[unLo];
                    fmap[unLo++] = fmap[unHi];
                    fmap[unHi--] = temp;
                }

                if (gtHi < ltLo) {
                    stack_ll[sp] = lo;
                    stack_hh[sp] = hi;
                    stack_dd[sp] = d1;
                } else {
                    int n = Math.min(ltLo - lo, unLo - ltLo);
                    vswap(fmap, lo, unLo - n, n);
                    int m = Math.min(hi - gtHi, gtHi - unHi);
                    vswap(fmap, unLo, hi - m + 1, m);

                    n = lo + unLo - ltLo - 1;
                    m = hi - (gtHi - unHi) + 1;

                    stack_ll[sp] = lo;
                    stack_hh[sp] = n;
                    stack_dd[sp] = d;
                    sp++;

                    stack_ll[sp] = n + 1;
                    stack_hh[sp] = m - 1;
                    stack_dd[sp] = d1;
                    sp++;

                    stack_ll[sp] = m;
                    stack_hh[sp] = hi;
                    stack_dd[sp] = d;
                }
                sp++;
            }
        }
    }
