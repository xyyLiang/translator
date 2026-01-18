    protected func slowDown(startTime: Int64, actDiff: Int64) {
        let ratio: Int64 = actDiff / kMaxClockAdvance
        var delay: Int64

        if(ratio < 2) {
            delay = 1
        } else if (ratio < 10) {
            delay = 2
        } else if (ratio < 600) {
            delay = 3;
        } else {
            delay = 5;
        }

        _logger.warn("Need to wait for ${delay.toString()} milliseconds; virtual clock advanced too far in the future")
        let waitUntil: Int64 = startTime + delay
        var counter: Int32 = 0
        do {
            try {
                sleep(delay * Duration.millisecond)
            } catch (ie: InterruptedException ){
                throw InterruptedException("Failed to sleep ");
            }
            delay = 1
            
            counter++
            if (counter > MAX_WAIT_COUNT) {
                break
            }
        } while (Int64(DateTime.now().toUnixTimeStamp().toMilliseconds()) < waitUntil)

    }