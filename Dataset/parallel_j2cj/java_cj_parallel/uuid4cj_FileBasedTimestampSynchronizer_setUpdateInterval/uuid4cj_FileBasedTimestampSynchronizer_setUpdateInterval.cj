    public func setUpdateInterval(interval: Int64) {
        if (interval < 1) {
            throw IllegalArgumentException("Illegal value (${interval}); has to be a positive integer value")
        }
        
        mInterval = interval
    }