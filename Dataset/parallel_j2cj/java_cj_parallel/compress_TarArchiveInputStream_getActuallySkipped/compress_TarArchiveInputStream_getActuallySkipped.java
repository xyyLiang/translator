    private long getActuallySkipped(final long available, final long skipped, final long expected) throws IOException {
        long actuallySkipped = skipped;
        if (in instanceof FileInputStream) {
            actuallySkipped = Math.min(skipped, available);
        }

        if (actuallySkipped != expected) {
            throw new IOException("Truncated TAR archive");
        }

        return actuallySkipped;
    }