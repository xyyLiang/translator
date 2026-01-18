    public FileBasedTimestampSynchronizer()
        throws IOException
    {
        this(new File(DEFAULT_LOCK_FILE_NAME1), new File(DEFAULT_LOCK_FILE_NAME2));
    }