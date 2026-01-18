public void cancel(IdentifiedTask[] tasks) {
    skipProceedCallCount.incrementAndGet();
    cancelLocked(tasks);
    skipProceedCallCount.decrementAndGet();
    processCalls();
}