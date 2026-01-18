    public func signalSchedulingChange(candidateNewNextFireTime: Int64 ) : Unit {
        synchronized(sigLock) {
            signaled = true;
            signaledNextFireTime = candidateNewNextFireTime;
            sigLock.notifyAll();
        }
    }