    @OverflowWrapping  
    public override func generate(name: String): UUID {
        return generate(UInt8ToInt8(_utf8.newEncoder().encode(name)))
    }