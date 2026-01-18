    @OverflowWrapping
    public static func unsynchroniseBuffer(bytes: Array<Int8>): Array<Int8> {
        var count: Int32 = sizeUnsynchronisationWouldAdd(bytes)
        if (count == 0) {
            return bytes
        }
        var newBuffer: Array<Int8> = Array<Int8>(bytes.size + Int64(count), {_ => 0})
        var j: Int64 = 0
        for (i in 0..(bytes.size - 1)) {
            newBuffer[j] = bytes[i]
            j++
            if (bytes[i] == Int8(0xff) && ((bytes[i + 1] & Int8(0xe0)) == Int8(0xe0) || bytes[i + 1] == 0)) {
                newBuffer[j] = 0
                j++
            }
        }
        newBuffer[j] = bytes[bytes.size - 1]
        j++
        if (bytes[bytes.size - 1] == Int8(0xff)) {
            newBuffer[j] = 0
            j++
        }
        return newBuffer
    }