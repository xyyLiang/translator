    protected byte[] readRecord() throws IOException {
        final int readNow = IOUtils.readFully(in, recordBuffer);
        count(readNow);
        if (readNow != recordSize) {
            return null;
        }

        return recordBuffer;
    }