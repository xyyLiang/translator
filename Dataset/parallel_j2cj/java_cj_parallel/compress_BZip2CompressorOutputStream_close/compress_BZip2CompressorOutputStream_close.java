    @Override
    public void close() throws IOException {
        if (!closed) {
            try (OutputStream outShadow = this.out) {
                finish();
            }
        }
    }