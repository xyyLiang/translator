    private static synchronized UUIDTimer sharedTimer()
    {
        if (_sharedTimer == null) {
            try {
                _sharedTimer = new UUIDTimer(new java.util.Random(System.currentTimeMillis()), null);
            } catch (IOException e) {
                throw new IllegalArgumentException("Failed to create UUIDTimer with specified synchronizer: "+e.getMessage(), e);
            }
        }
        return _sharedTimer;
    }