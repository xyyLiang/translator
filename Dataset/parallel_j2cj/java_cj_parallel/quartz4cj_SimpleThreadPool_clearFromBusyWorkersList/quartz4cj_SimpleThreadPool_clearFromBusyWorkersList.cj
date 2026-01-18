    func clearFromBusyWorkersList( wt: WorkerThread) : Unit {
        synchronized(nextRunnableLock) {
            busyWorkers.remove(wt);
            nextRunnableLock.notifyAll();
        }
    }