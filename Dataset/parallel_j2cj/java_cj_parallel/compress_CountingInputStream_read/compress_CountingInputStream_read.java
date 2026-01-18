    @Override
    public int read() throws IOException {
        final int r = in.read();
        if (r >= 0) {
            count(1);
        }
        return r;
    }