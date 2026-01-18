    @OverflowWrapping
    private static func formatLongBinary(value: Int64, buf: Array<Byte>, offset: Int64, length: Int64, negative: Bool): Unit {
        var bits: Int64 = (length - 1) * 8
        var max: Int64 = if (bits >= 0) {
            1 << bits 
        } else {
            math.rotate(1, Int8(bits))
        }
        // Long.MIN_VALUE stays Long.MIN_VALUE
        var val: Int64 = math.abs(value)
        if (val < 0 || val >= max) {
            throw IllegalArgumentException("Value ${value} is too large for ${length} byte field.")
        }
        if (negative) {
            val ^= max - 1
            val++
            val |= if (bits >= 0) {
                0xff << bits 
            } else {
                math.rotate(0xff, Int8(bits))
            }
        }
        for (i in Int64(Int32(offset) + Int32(length) - 1)..=offset : -1) {
            buf[i] = UInt8(val)
            val >>= 8
        }
    }