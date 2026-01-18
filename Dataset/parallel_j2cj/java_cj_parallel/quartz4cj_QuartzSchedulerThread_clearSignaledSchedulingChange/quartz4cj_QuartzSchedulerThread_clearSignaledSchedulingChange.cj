    public func clearSignaledSchedulingChange() : Unit  {
        synchronized(sigLock) {
            signaled = false;
            signaledNextFireTime = 0;
        }
    }