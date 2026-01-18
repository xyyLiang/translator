    private static int bsR(final BitInputStream bin, final int n) throws IOException {
        final long thech = bin.readBits(n);
        if (thech < 0) {
            throw new IOException("Unexpected end of stream");
        }
        return (int) thech;
    }