    @OverflowWrapping
    public static func synchroniseBuffer(bytes: Array<Int8>): Array<Int8> {
        var count: Int32 = sizeSynchronisationWouldSubtract(bytes)
        if (count == 0) {
            return bytes
        }
        var newBuffer: Array<Int8> = Array<Int8>(bytes.size - Int64(count), {_ => 0})
        var i: Int64 = 0
        for (j in 0..newBuffer.size - 1) {
            newBuffer[j] = bytes[i]
            if (bytes[i] == Int8(0xff) && bytes[i + 1] == 0 && ((bytes[i + 2] & Int8(0xe0)) == Int8(0xe0) ||
                bytes[i + 2] == 0)) {
                i++
            }
            i++
        }
        newBuffer[newBuffer.size - 1] = bytes[i]
        return newBuffer
    }