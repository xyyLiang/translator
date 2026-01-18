    public func isStarted()  : Bool {
        return !shuttingDown && !closed && !isInStandbyMode() && initialStart.isPresent(); 
    }