    @OverflowWrapping
    public static func formatCheckSumOctalBytes(value: Int64, buf: Array<Byte>, offset: Int64, length: Int64): Int64 {
        var idx: Int64 = length - 2 // for NUL and space
        formatUnsignedOctalString(value, buf, offset, idx)
        buf[offset + idx] = 0 // Trailing null
        idx++
        buf[offset + idx] = UInt8(UInt32(' ')) // Trailing space
        return offset + length
    }