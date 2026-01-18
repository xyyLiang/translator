    DownloadDispatcher(List<DownloadCall> readyAsyncCalls,
                       List<DownloadCall> runningAsyncCalls,
                       List<DownloadCall> runningSyncCalls,
                       List<DownloadCall> finishingCalls) {
        this.readyAsyncCalls = readyAsyncCalls;
        this.runningAsyncCalls = runningAsyncCalls;
        this.runningSyncCalls = runningSyncCalls;
        this.finishingCalls = finishingCalls;
    }