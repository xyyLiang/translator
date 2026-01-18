    private int readNextByte(final BitInputStream in) throws IOException {
        final long b = in.readBits(8);
        return (int) b;
    }