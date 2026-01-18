    private synchronized void processCalls() {
        if (skipProceedCallCount.get() > 0) return;
        if (runningAsyncSize() >= maxParallelRunningCount) return;
        if (readyAsyncCalls.isEmpty()) return;

        for (Iterator<DownloadCall> i = readyAsyncCalls.iterator(); i.hasNext(); ) {
            DownloadCall call = i.next();

            i.remove();

            final DownloadTask task = call.task;
            if (isFileConflictAfterRun(task)) {
                OkDownload.with().callbackDispatcher().dispatch().taskEnd(task, EndCause.FILE_BUSY,
                        null);
                continue;
            }

            runningAsyncCalls.add(call);
            getExecutorService().execute(call);

            if (runningAsyncSize() >= maxParallelRunningCount) return;
        }
    }