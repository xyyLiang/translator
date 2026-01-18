    protected static func _randomNumberGenerator():SecureRandom{
        synchronized(m) {
            _rnd = match (_rnd) {
                case Some(_) => _rnd
                case None => SecureRandom()
            }
            return _rnd.getOrThrow()
        }
    }