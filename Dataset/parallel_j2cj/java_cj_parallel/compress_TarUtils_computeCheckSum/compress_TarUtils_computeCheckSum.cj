    public static func computeCheckSum(buf: Array<Byte>): Int64 {
        var sum: Int64 = 0
        for (element in buf) {
            sum += BYTE_MASK & Int64(element)
        }
        return sum
    }