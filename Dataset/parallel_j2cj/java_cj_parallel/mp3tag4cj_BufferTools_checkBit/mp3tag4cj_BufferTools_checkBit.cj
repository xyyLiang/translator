    @OverflowWrapping
    public static func checkBit(b: Int8, bitPosition: Int64): Bool {
        return ((b & (1 << bitPosition)) != 0)
    }