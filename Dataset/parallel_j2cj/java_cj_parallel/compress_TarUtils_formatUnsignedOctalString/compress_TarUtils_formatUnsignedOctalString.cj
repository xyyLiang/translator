    @OverflowWrapping
    public static func formatUnsignedOctalString(value: Int64, buffer: Array<Byte>, offset: Int64, length: Int64): Unit {
        var remaining: Int64 = length
        remaining = Int64(Int32(remaining)-1)
        if (value == 0) {
            buffer[offset + remaining] = UInt8(UInt32('0'))
            remaining = Int64(Int32(remaining)-1)
        } else {
            var val: Int64 = value
            while (remaining >= 0 && val != 0) {
                // CheckStyle:MagicNumber OFF
                buffer[offset + remaining] = UInt8(UInt32('0')) + UInt8(val & 7)
                val = URS(val, 3)
                // CheckStyle:MagicNumber ON
                remaining = Int64(Int32(remaining)-1)
            }
            if (val != 0) {
                throw IllegalArgumentException("${value}=${value.format("o")} will not fit in octal number buffer of length ${length}")
            }
        }

        while (remaining >= 0) { // leading zeros
            buffer[offset + remaining] = UInt8(UInt32('0'))
            remaining = Int64(Int32(remaining)-1)
        }
    }