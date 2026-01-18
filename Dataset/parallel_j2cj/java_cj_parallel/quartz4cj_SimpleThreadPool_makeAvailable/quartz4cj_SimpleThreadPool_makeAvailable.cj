    func makeAvailable( wt: WorkerThread) : Unit {
        synchronized(nextRunnableLock) {
            if(!isShutdown) { 
                availWorkers.append(wt);
            }
            busyWorkers.remove(wt);
            nextRunnableLock.notifyAll();
        }
    }
