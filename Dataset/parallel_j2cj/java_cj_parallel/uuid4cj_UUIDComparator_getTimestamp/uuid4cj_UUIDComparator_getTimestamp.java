    public synchronized long getTimestamp()
    {
        long systime = _clock.currentTimeMillis();
        if (systime < _lastSystemTimestamp) {
            _logger.warn("System time going backwards! (got value %d, last %d)",
                    systime, _lastSystemTimestamp);
            _lastSystemTimestamp = systime;
        }
        if (systime <= _lastUsedTimestamp) {
            if (_clockCounter < kClockMultiplier) { 
                systime = _lastUsedTimestamp;
            } else { 
                long actDiff = _lastUsedTimestamp - systime;
                long origTime = systime;
                systime = _lastUsedTimestamp + 1L;

                _logger.warn("Timestamp over-run: need to reinitialize random sequence");

                initCounters(_random);

                if (actDiff >= kMaxClockAdvance) {
                    slowDown(origTime, actDiff);
                }
            }
        } else {
            _clockCounter &= 0xFF;
        }
        _lastUsedTimestamp = systime;
        if (_syncer != null && systime >= _firstUnsafeTimestamp) {
            try {
                _firstUnsafeTimestamp = _syncer.update(systime);
            } catch (IOException ioe) {
                throw new RuntimeException("Failed to synchronize timestamp: "+ioe);
            }
        }
        systime *= kClockMultiplierL;
        systime += kClockOffset;
        systime += _clockCounter;
        ++_clockCounter;
        return systime;
    }