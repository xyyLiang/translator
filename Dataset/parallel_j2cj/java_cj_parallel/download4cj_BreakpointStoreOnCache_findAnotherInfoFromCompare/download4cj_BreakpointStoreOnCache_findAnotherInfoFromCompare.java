    @Override
    public BreakpointInfo findAnotherInfoFromCompare(@NonNull DownloadTask task,
                                                     @NonNull BreakpointInfo ignored) {
        final SparseArray<BreakpointInfo> clonedMap;
        synchronized (this) {
            clonedMap = storedInfos.clone();
        }
        final int size = clonedMap.size();
        for (int i = 0; i < size; i++) {
            final BreakpointInfo info = clonedMap.valueAt(i);
            if (info == ignored) continue;

            if (info.isSameFrom(task)) {
                return info;
            }
        }

        return null;
    }