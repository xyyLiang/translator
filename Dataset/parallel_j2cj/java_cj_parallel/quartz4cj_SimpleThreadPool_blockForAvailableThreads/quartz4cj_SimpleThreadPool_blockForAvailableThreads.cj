    public func blockForAvailableThreads() : Int64 {
        synchronized(nextRunnableLock) {

            while((availWorkers.size < 1 || handoffPending) && !isShutdown) {
                nextRunnableLock.wait(timeout: Duration.millisecond * 500);
            }

            return availWorkers.size;
        }
    }