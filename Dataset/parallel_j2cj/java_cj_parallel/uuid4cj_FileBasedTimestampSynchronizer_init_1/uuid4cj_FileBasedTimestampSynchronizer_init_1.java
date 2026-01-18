    public FileBasedTimestampSynchronizer(File lockFile1, File lockFile2)
        throws IOException
    {
        this(lockFile1, lockFile2, DEFAULT_UPDATE_INTERVAL);
    }