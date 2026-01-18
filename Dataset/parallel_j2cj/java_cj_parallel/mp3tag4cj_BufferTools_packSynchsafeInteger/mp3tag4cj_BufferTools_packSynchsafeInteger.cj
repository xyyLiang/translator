    @OverflowWrapping
    public static func packSynchsafeInteger(i: Int32): Array<Int8> {
        var bytes: Array<Int8> = Array<Int8>(4, {_ => 0})
        packSynchsafeInteger(i, bytes, 0)
        return bytes
    }