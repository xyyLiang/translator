    static func computeDelayForRepeatedErrors( jobStore: JobStore, acquiresFailed: Int64 ) : Int64 {
        var delay: Int64 
        try {
            delay = jobStore.getAcquireRetryDelay(acquiresFailed);
        } catch ( ignored: Exception) {
            // we're trying to be useful in case of error states, not cause additional errors..
            delay = 100;
        }
        // sanity check per getAcquireRetryDelay specification

        if (delay < MIN_DELAY) {
            delay = MIN_DELAY;
        }
        if (delay > MAX_DELAY) {
            delay = MAX_DELAY;
        }

        return delay;
    }