    @OverflowWrapping
    private static func formatBigIntegerBinary( value: Int64, buf: Array<Byte>, offset: Int64, length: Int64, negative: Bool ): Unit {
        var val: BigInt = BigInt(value)
        var b: Array<Byte> = EncodingUtils.encoded(val)
        var len: Int64 = b.size
        if (len > length - 1) {
            throw IllegalArgumentException("Value '${value}' is too large for '${length} byte field.")
        }
        var off: Int64 = offset + length - len
        b.copyTo(buf, 0, off, len)
        var fill: Byte = if (negative) {
            0xff
        } else {
            0
        }
        for (i in offset + 1..off) {
            buf[i] = fill
        }
    }