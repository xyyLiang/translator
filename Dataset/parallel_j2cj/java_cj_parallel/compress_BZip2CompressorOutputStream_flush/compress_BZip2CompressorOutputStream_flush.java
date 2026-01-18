    @Override
    public void flush() throws IOException {
        final OutputStream outShadow = this.out;
        if (outShadow != null) {
            outShadow.flush();
        }
    }