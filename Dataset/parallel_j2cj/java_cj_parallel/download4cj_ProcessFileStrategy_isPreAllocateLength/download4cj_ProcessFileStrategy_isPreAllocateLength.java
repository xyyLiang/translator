    public boolean isPreAllocateLength(@NonNull DownloadTask task) {
        // if support seek, enable pre-allocate length.
        boolean supportSeek = OkDownload.with().outputStreamFactory().supportSeek();
        if (!supportSeek) return false;

        if (task.getSetPreAllocateLength() != null) return task.getSetPreAllocateLength();
        return true;
    }