    @Override
    public long update(long now)
        throws IOException
    {
        long nextAllowed = now + mInterval;

        /* We have to make sure to (over)write the one that is NOT
         * actively used, to ensure that we always have fully persisted
         * timestamp value, even if the write process gets interruped
         * half-way through.
         */

        if (mFirstActive) {
            mLocked2.writeStamp(nextAllowed);
        } else {
            mLocked1.writeStamp(nextAllowed);
        }

        mFirstActive = !mFirstActive;

        return nextAllowed;
    }