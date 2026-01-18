    protected void slowDown(long startTime, long actDiff)
    {
        long ratio = actDiff / kMaxClockAdvance;
        long delay;
        
        if (ratio < 2L) { // 200 msecs or less
            delay = 1L;
        } else if (ratio < 10L) { // 1 second or less
            delay = 2L;
        } else if (ratio < 600L) { // 1 minute or less
            delay = 3L;
        } else {
            delay = 5L;
        }
        _logger.warn("Need to wait for %d milliseconds; virtual clock advanced too far in the future", delay);
        long waitUntil = startTime + delay;
        int counter = 0;
        do {
            try {
                Thread.sleep(delay);
            } catch (InterruptedException ie) { }
            delay = 1L;
            if (++counter > MAX_WAIT_COUNT) {
                break;
            }
        } while (System.currentTimeMillis() < waitUntil);
    }