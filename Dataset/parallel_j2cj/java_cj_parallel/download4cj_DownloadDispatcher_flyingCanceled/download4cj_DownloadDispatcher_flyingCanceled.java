    public synchronized void flyingCanceled(DownloadCall call) {
        Util.d(TAG, "flying canceled: " + call.task.getId());
        if (call.asyncExecuted) flyingCanceledAsyncCallCount.incrementAndGet();
    }
