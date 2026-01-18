public boolean cancel(IdentifiedTask task) {
    skipProceedCallCount.incrementAndGet();
    final boolean result = cancelLocked(task);
    skipProceedCallCount.decrementAndGet();
    processCalls();
    return result;
}