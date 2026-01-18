    public static func parseOctalOrBinary(buffer: Array<Byte>, offset: Int64, length: Int64): Int64 {
        if ((buffer[offset] & 0x80) == 0) {
            return parseOctal(buffer, offset, length)
        }
        var negative: Bool = buffer[offset] == 0xff
        if (length < 9) {
            return parseBinaryLong(buffer, offset, length, negative)
        }
        return parseBinaryBigInteger(buffer, offset, length, negative)
    }