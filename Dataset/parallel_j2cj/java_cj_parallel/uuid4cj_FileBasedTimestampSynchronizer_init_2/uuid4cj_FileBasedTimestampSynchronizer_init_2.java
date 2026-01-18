    public FileBasedTimestampSynchronizer(File lockFile1, File lockFile2, long interval)
        throws IOException
    {
        mInterval = interval;
        mLocked1 = new LockedFile(lockFile1);

        boolean ok = false;
        try {
            mLocked2 = new LockedFile(lockFile2);
            ok = true;
        } finally {
            if (!ok) {
                mLocked1.deactivate();
            }
        }
    }