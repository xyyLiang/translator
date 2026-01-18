    public UUIDTimer(Random rnd, TimestampSynchronizer sync, UUIDClock clock) throws IOException
    {
        _random = rnd;
        _syncer = sync;
        _clock = clock;
        initCounters(rnd);
        _lastSystemTimestamp = 0L;
        _lastUsedTimestamp = 0L;
        if (sync != null) {
            long lastSaved = sync.initialize();
            if (lastSaved > _lastUsedTimestamp) {
                _lastUsedTimestamp = lastSaved;
            }
        }
        _firstUnsafeTimestamp = 0L; 
    }