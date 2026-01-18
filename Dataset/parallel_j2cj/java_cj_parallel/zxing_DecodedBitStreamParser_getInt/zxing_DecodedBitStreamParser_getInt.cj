    static func getInt(bytes: Array<UInt8>, x: Array<UInt8>): Int64 {
        var val = 0
        for (i in 0..x.size) {
            val += getBit(Int64(x[i]), bytes) << (x.size - i - 1)
        }
        val
    }