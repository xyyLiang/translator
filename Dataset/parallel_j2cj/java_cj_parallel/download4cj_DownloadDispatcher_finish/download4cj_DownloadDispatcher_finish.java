    public synchronized void finish(DownloadCall call) {
        final boolean asyncExecuted = call.asyncExecuted;
        final Collection<DownloadCall> calls;
        if (finishingCalls.contains(call)) {
            calls = finishingCalls;
        } else if (asyncExecuted) {
            calls = runningAsyncCalls;
        } else {
            calls = runningSyncCalls;
        }
        if (!calls.remove(call)) throw new AssertionError("Call wasn't in-flight!");
        if (asyncExecuted && call.isCanceled()) flyingCanceledAsyncCallCount.decrementAndGet();
        if (asyncExecuted) processCalls();
    }