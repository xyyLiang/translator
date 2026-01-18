    private synchronized void enqueueIgnorePriority(DownloadTask task) {
        final DownloadCall call = DownloadCall.create(task, true, store);
        if (runningAsyncSize() < maxParallelRunningCount) {
            runningAsyncCalls.add(call);
            getExecutorService().execute(call);
        } else {
            // priority
            readyAsyncCalls.add(call);
        }
    }