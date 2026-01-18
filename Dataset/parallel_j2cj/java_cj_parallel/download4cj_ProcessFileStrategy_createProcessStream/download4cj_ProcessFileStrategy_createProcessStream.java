    @NonNull public MultiPointOutputStream createProcessStream(@NonNull DownloadTask task,
                                                               @NonNull BreakpointInfo info,
                                                               @NonNull DownloadStore store) {
        return new MultiPointOutputStream(task, info, store);
    }