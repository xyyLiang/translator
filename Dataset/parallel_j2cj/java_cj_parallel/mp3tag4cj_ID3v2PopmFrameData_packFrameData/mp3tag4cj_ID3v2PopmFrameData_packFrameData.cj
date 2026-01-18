    public func packFrameData(): Array<Int8> {
        var bytes: Array<Int8> = BufferTools.transUInt8ArrayToInt8(address.getOrThrow().toArray())
        var newBytes: Array<Int8> = Array<Int8>(bytes.size + 2, {_ => 0})
        for (index in 0..bytes.size) {
            newBytes[index] = bytes[index]
        }
        newBytes[newBytes.size - 2] = 0
        newBytes[newBytes.size - 1] = wmp9encodedRatings[Int64(rating)]
        return newBytes
    }