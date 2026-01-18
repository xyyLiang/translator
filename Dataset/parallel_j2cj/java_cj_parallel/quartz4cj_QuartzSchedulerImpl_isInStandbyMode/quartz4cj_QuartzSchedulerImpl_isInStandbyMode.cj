    public func isInStandbyMode() : Bool  {
        getSchedThread().isPaused();
    }