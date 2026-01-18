    private static func sharedTimer(): Option<UUIDTimer> {
        try {
            _sharedTimer = match (_sharedTimer) {
                case Some(_) => _sharedTimer
                case None => UUIDTimer(SecureRandom(), Option<FileBasedTimestampSynchronizer>.None);
            }
        } catch (e: IllegalArgumentException) {
            throw InterruptedException("Failed to create UUIDTimer with specified synchronizer: " + e.toString())
        }

        return _sharedTimer;
    }