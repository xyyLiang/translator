    public func generate(): UUID {
        let rawTimestamp: Int64 = UUIDClock().currentTimeMillis()
        var rnd: Array<UInt8> = Array<UInt8>(10, item: 0)
        match(_random) {
            case Some(_) => 
                rnd = _random.getOrThrow().nextBytes(10)
            case None => 
                rnd = _srandom.getOrThrow().nextBytes(10)
        }
        let l1: Int64 = (rawTimestamp << 16) | _toShort(rnd, 8)
        let l2: Int64 = _toLong(rnd, 0)
        return UUIDUtil.constructUUID(UUIDType.TIME_BASED_EPOCH, l1, l2)
    }