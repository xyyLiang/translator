    public synchronized void write(int blockIndex, byte[] bytes, int length) throws IOException {
        // if this task has been canceled, there is no need to write because of the output stream
        // has been closed and there is no need to create a new output stream if this is a first
        // write of this task block
        if (canceled) return;

        outputStream(blockIndex).write(bytes, 0, length);

        // because we add the length value after flush and sync,
        // so the length only possible less than or equal to the real persist length.
        allNoSyncLength.addAndGet(length);
        noSyncLengthMap.get(blockIndex).addAndGet(length);

        inspectAndPersist();
    }