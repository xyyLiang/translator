    public init(rnd:SecureRandom,sync:Option<FileBasedTimestampSynchronizer>,clock:UUIDClock){
        _random = rnd
        _syncer = sync
        _clock = clock
        initCounters(rnd)
        _lastSystemTimestamp = 0
        _lastUsedTimestamp = 0
        if(let Some(_) <- sync){
            let lastSaved:Int64 = sync.getOrThrow().initialize()
            if(lastSaved > _lastUsedTimestamp){
                _lastUsedTimestamp = lastSaved
            }
        }
        _firstUnsafeTimestamp = 0
    }