    protected void makeAvailable(WorkerThread wt) {
        synchronized(nextRunnableLock) {
            if(!isShutdown) {
                availWorkers.add(wt);
            }
            busyWorkers.remove(wt);
            nextRunnableLock.notifyAll();
        }
    }