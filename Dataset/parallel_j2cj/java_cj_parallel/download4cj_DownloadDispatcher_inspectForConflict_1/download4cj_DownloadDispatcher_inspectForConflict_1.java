    private boolean inspectForConflict(@NonNull DownloadTask task,
                                       @Nullable Collection<DownloadTask> sameTaskList,
                                       @Nullable Collection<DownloadTask> fileBusyList) {
        return inspectForConflict(task, readyAsyncCalls, sameTaskList, fileBusyList)
                || inspectForConflict(task, runningAsyncCalls, sameTaskList, fileBusyList)
                || inspectForConflict(task, runningSyncCalls, sameTaskList, fileBusyList);
    }