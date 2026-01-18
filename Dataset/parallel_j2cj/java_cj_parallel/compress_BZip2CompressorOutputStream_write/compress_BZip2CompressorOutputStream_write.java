    @Override
    public void write(final int b) throws IOException {
        if (closed) {
            throw new IOException("Closed");
        }
        write0(b);
    }