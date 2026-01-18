    @OverflowWrapping
    public static func formatLongOctalOrBinaryBytes(value: Int64, buf: Array<Byte>, offset: Int64, length: Int64): Int64 {
        // Check whether we are dealing with UID/GID or SIZE field
        var maxAsOctalChar: Int64 = if (length == TarConstants.UIDLEN) {
            TarConstants.MAXID
        } else {
            TarConstants.MAXSIZE
        }
        var negative: Bool = value < 0
        if (!negative && value <= maxAsOctalChar) {
            // OK to store as octal chars
            return formatLongOctalBytes(value, buf, offset, length)
        }
        if (length < 9) {
            formatLongBinary(value, buf, offset, length, negative)
        } else {
            formatBigIntegerBinary(value, buf, offset, length, negative)
        }
        buf[offset] = if (negative) {
            0xff
        } else {
            0x80
        }
        return offset + length
    }