    protected func initialize():Int64 {
        let ts1: Int64 = mLocked1.readStamp()
        let ts2: Int64 = mLocked2.readStamp()
        var result: Int64
        if(ts1 > ts2) {
            mFirstActive = true
            result = ts1
        } else {
            mFirstActive = false
            result = ts2
        }
        if (result <= 0) {
            logger.warn("Could not determine safe timer starting point: assuming current system time is acceptable")
        } else {
            let now: Int64 = Int64(DateTime.now().toUnixTimeStamp().toMilliseconds())
            if ((now + mInterval) < result) {
                logger.warn("Safe timestamp read is ${result - now} milliseconds in future, and is greater than the inteval (${mInterval})")
            }
        }

        return result
     }