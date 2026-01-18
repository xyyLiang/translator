    @OverflowWrapping
    func fill(value: Int64, offset: Int64, outbuf: Array<Byte>, length: Int64): Int64 {
        fill(UInt8(value), offset, outbuf, length)
    }