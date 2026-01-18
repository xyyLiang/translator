    @Override
    public UUID generate()
    {
        return construct(_clock.currentTimeMillis());
    }
    
    public UUID construct(long rawTimestamp)
    {
        lock.lock();
        try { 
            if (rawTimestamp == _lastTimestamp) {
                boolean c = true;
                for (int i = ENTROPY_BYTE_LENGTH - 1; i >= 0; i--) {
                    if (c) {
                        byte temp = _lastEntropy[i];
                        temp = (byte) (temp + 0x01);
                        c = _lastEntropy[i] == (byte) 0xff && c;
                        _lastEntropy[i] = temp;
                    }
                }
                if (c) {
                    throw new IllegalStateException("overflow on same millisecond");
                }
            } else {
                _lastTimestamp = rawTimestamp;
                _random.nextBytes(_lastEntropy);
            }
            return UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, (rawTimestamp << 16) | _toShort(_lastEntropy, 0), _toLong(_lastEntropy, 2));
        } finally {
            lock.unlock();
        }
    }