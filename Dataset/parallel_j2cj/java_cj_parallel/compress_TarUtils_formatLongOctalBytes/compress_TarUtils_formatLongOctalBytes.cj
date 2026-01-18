    @OverflowWrapping
    public static func formatLongOctalBytes(value: Int64, buf: Array<Byte>, offset: Int64, length: Int64): Int64 {
        let idx: Int64 = Int64(Int32(length) - 1)

        formatUnsignedOctalString(value, buf, offset, idx)
        buf[offset + idx] = UInt8(UInt32(' ')) // Trailing space
        return offset + length
    }
