    @OverflowWrapping
    public override func generate(nameBytes: Array<Int8>): UUID {
        var digest: Array<Int8> = Array<Int8>()
        _digester.getOrThrow().reset()
        match (_namespace) {
            case Some(v) =>
                _digester.getOrThrow().update(UUIDUtil.asByteArray(v))
                _digester.getOrThrow().update(Int8ToUInt8(nameBytes))
                digest = _digester.getOrThrow().digest()
            case None => 
                digest = _digester.getOrThrow().digest(input: nameBytes)
        }
        return UUIDUtil.constructUUID(_types.getOrThrow(), digest)
    }