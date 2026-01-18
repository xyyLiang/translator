    protected synchronized static Random _randomNumberGenerator()
    {
        if (_rnd == null) {
            _rnd = new SecureRandom();
        }
        return _rnd;
    }