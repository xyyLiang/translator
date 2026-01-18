    public void enqueue(DownloadTask task) {
        skipProceedCallCount.incrementAndGet();
        enqueueLocked(task);
        skipProceedCallCount.decrementAndGet();
    }