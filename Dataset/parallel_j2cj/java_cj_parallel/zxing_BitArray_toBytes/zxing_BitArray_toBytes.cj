    @overflowWrapping
    public func toBytes(bitOffset: Int64, array: Array<Int8>, offset: Int64, numBytes: Int64) {
        var mBitOffset = bitOffset
        for (i in 0..numBytes) {
            var theByte = 0
            for (j in 0..8) {
                if (get(mBitOffset)) {
                    theByte |= 1 << (7 - j)
                }
                mBitOffset++
            }
            array[offset + i] = Int8(theByte)
        }
    }