    @Override
    public int read(final byte[] buf, final int off, final int len) throws IOException {
        if (len == 0) {
            return 0;
        }
        final int ret = in.read(buf, off, len);
        count(ret);
        return ret;
    }