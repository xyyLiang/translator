    static DownloadChain createChain(int blockIndex, DownloadTask task,
                                     @NonNull BreakpointInfo info,
                                     @NonNull DownloadCache cache,
                                     @NonNull DownloadStore store) {
        return new DownloadChain(blockIndex, task, info, cache, store);
    }