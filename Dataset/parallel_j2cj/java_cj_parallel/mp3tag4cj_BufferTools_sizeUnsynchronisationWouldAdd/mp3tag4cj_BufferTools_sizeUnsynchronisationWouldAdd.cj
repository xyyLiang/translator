    @OverflowWrapping
    public static func sizeUnsynchronisationWouldAdd(bytes: Array<Int8>): Int32 {
        var count: Int32 = 0
        for (i in (0..bytes.size - 1)) {
            if (bytes[i] == Int8(0xff) && ((bytes[i + 1] & Int8(0xe0)) == Int8(0xe0) || bytes[i + 1] == 0)) {
                count++
            }
        }
        if (bytes.size > 0 && bytes[bytes.size - 1] == Int8(0xff)) {
            count++
        }
        return count
    }