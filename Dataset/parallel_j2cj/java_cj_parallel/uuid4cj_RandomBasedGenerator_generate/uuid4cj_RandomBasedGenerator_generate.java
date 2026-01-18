    @Override
    public UUID generate()
    {
        // 14-Oct-2010, tatu: Surprisingly, variant for reading byte array is
        //   tad faster for SecureRandom... so let's use that then

        long r1, r2;

        if (_secureRandom) {
            final byte[] buffer = new byte[16];
            _random.nextBytes(buffer);
            r1 = _toLong(buffer, 0);
            r2 = _toLong(buffer, 1);
        } else {
            r1 = _random.nextLong();
            r2 = _random.nextLong();
        }
        return UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, r1, r2);
    }