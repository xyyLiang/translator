    private static func parseBinaryLong(buffer: Array<Byte>, offset: Int64, length: Int64, negative: Bool): Int64 {
        if (length >= 9) {
            throw IllegalArgumentException(/* "At offset " + offset + ", "
            + length + " byte binary Int64"
            + " exceeds maximum signed long"
            + " value" */)
        }
        var val: Int64 = 0
        for (i in  1..length) {
            val = (val << 8) + Int64(buffer[offset + i] & 0xff)
        }
        if (negative) {
            // 2's complement
            val--
            val ^= Int64(math.pow(2.0, Float64(length - 1) * 8.0)) - 1
        }
        return if (negative) {
            -val
        } else {
            val
        }
    }