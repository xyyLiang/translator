    public override func generate():UUID { 
        let r1: Int64
        let r2: Int64
        
       if (_secureRandom) {
            let buffer: Array<UInt8> = Array<UInt8>(_sRandom.nextBytes(16))
            r1 = _toLong(buffer, 0);
            r2 = _toLong(buffer, 1);
        } else {
            r1 = safeRandom()
            r2 = safeRandom()
        }
        return UUIDUtil.constructUUID(UUIDType.RANDOM_BASED, r1, r2);
    }