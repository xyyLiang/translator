    @Override
    protected long initialize() throws IOException
    {
        long ts1 = mLocked1.readStamp();
        long ts2 = mLocked2.readStamp();
        long result;

        if (ts1 > ts2) {
            mFirstActive = true;
            result = ts1;
        } else {
            mFirstActive = false;
            result = ts2;
        }

        /* Hmmh. If we didn't get a time stamp (-> 0), or if written time is
         * ahead of current time, let's log something:
         */
        if (result <= 0L) {
            logger.warn("Could not determine safe timer starting point: assuming current system time is acceptable");
        } else {
            long now = System.currentTimeMillis();
            //long diff = now - result;

            /* It's more suspicious if old time was ahead... although with
             * longer iteration values, it can be ahead without errors. So
             * let's base check on current iteration value:
             */
            if ((now + mInterval) < result) {
                logger.warn("Safe timestamp read is {} milliseconds in future, and is greater than the inteval ({})",  (result - now), mInterval);
            }

            /* Hmmh. Is there any way a suspiciously old timestamp could be
             * harmful? It can obviously be useless but...
             */
        }
        
        return result;
    }