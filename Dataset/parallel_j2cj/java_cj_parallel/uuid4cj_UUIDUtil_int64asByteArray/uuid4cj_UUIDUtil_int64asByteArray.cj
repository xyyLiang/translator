    @OverflowWrapping
    public static func int64asByteArray(hi: Int64, lo: Int64): Array<Int8> {
        var result: Array<Int8> = Array<Int8>(16, item: 0)
        appendInt(Int32(hi >> 32), result, 0)
        appendInt(Int32(hi), result, 4)
        appendInt(Int32(lo >> 32), result, 8)
        appendInt(Int32(lo), result, 12)
        return result
    }