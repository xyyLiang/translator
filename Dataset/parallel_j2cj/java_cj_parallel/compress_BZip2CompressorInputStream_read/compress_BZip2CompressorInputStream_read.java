    @Override
    public int read() throws IOException {
        if (this.bin != null) {
            final int r = read0();
            count(r < 0 ? -1 : 1);
            return r;
        }
        throw new IOException("Stream closed");
    }