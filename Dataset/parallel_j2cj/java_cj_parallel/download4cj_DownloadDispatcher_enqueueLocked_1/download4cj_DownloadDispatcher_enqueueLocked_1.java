    private synchronized void enqueueLocked(DownloadTask task) {
        Util.d(TAG, "enqueueLocked for single task: " + task);
        if (inspectCompleted(task)) return;
        if (inspectForConflict(task)) return;

        final int originReadyAsyncCallSize = readyAsyncCalls.size();
        enqueueIgnorePriority(task);
        if (originReadyAsyncCallSize != readyAsyncCalls.size()) Collections.sort(readyAsyncCalls);
    }