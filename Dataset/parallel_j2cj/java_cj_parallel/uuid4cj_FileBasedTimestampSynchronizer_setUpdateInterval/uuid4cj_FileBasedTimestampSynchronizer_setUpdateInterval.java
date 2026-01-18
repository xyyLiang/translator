    public void setUpdateInterval(long interval)
    {
        if (interval < 1L) {
            throw new IllegalArgumentException("Illegal value ("+interval+"); has to be a positive integer value");
        }
        mInterval = interval;
    }