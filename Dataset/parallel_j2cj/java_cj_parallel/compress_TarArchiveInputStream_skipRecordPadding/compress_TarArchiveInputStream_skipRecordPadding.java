    private void skipRecordPadding() throws IOException {
        if (!isDirectory() && this.entrySize > 0 && this.entrySize % this.recordSize != 0) {
            final long available = in.available();
            final long numRecords = this.entrySize / this.recordSize + 1;
            final long padding = numRecords * this.recordSize - this.entrySize;
            long skipped = org.apache.commons.io.IOUtils.skip(in, padding);

            skipped = getActuallySkipped(available, skipped, padding);

            count(skipped);
        }
    }