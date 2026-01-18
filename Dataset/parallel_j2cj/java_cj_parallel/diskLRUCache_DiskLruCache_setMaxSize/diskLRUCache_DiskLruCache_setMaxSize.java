  public synchronized void setMaxSize(long maxSize) {
    this.maxSize = maxSize;
    executorService.submit(cleanupCallable);
  }
