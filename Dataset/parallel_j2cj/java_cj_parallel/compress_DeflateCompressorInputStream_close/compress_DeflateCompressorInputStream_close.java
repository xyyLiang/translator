    @Override
    public void close() throws IOException {
        try {
            in.close();
        } finally {
            inflater.end();
        }
    }