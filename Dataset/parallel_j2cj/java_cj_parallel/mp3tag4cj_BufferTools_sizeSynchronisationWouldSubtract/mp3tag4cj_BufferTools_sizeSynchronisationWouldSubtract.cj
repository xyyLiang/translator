    public static func sizeSynchronisationWouldSubtract(bytes: Array<Int8>): Int32 {
        var count: Int32 = 0
        for (i in 0..(bytes.size - 2)) {
            if (bytes[i] == Int8(0xff) && bytes[i + 1] == 0 && ((bytes[i + 2] & Int8(0xe0)) == Int8(0xe0) ||
                bytes[i + 2] == 0)) {
                count++
            }
        }
        if (bytes.size > 1 && bytes[bytes.size - 2] == Int8(0xff) && bytes[bytes.size - 1] == 0) {
            count++
        }
        return count
    }