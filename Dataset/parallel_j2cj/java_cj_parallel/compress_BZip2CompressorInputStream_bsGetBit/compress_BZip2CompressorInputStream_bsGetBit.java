    private static boolean bsGetBit(final BitInputStream bin) throws IOException {
        return bsR(bin, 1) != 0;
    }