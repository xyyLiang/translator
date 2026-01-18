    @Override
    public int available() throws IOException {
        if (isDirectory()) {
            return 0;
        }
        if (currEntry.getRealSize() - entryOffset > Integer.MAX_VALUE) {
            return Integer.MAX_VALUE;
        }
        return (int) (currEntry.getRealSize() - entryOffset);
    }