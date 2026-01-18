    void releaseConnectionAsync() {
        EXECUTOR.execute(releaseConnectionRunnable);
    }