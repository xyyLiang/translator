    public void enqueue(DownloadTask[] tasks) {
        skipProceedCallCount.incrementAndGet();
        enqueueLocked(tasks);
        skipProceedCallCount.decrementAndGet();
    }