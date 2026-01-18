    public func getTimestamp(): Int64{
        var systime: Int64 = _clock.currentTimeMillis()
        if(systime < _lastSystemTimestamp) {
            _logger.warn("System time going backwards! (got value ${systime}, last  ${_lastSystemTimestamp})")
            _lastSystemTimestamp = systime

        }
        if (systime <= _lastUsedTimestamp) {
            if (_clockCounter < kClockMultiplier) {
                systime = _lastUsedTimestamp;
            } else {
                let actDiff: Int64 = _lastUsedTimestamp - systime
                let origTime: Int64 = systime
                systime = _lastUsedTimestamp + 1

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

        let isSyncer: Bool = match (_syncer) {
          case Some(_) => true
          case None => false
        }

        if ( isSyncer && systime >= _firstUnsafeTimestamp) {
            try {
                _firstUnsafeTimestamp = _syncer.getOrThrow().update(systime)
            } catch (ioe: FSException | IllegalArgumentException) {
                throw InterruptedException("Failed to synchronize timestamp")
            }
        }

        systime *= kClockMultiplierL;
        systime += kClockOffset;

        systime += Int64(_clockCounter);
        _clockCounter ++;
        return systime;
    }