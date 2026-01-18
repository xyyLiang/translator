    private func readCachedBits(count: Int64): Int64 {
        let bitsOut: Int64 = match (byteOrder) {
            case Endian.Little =>
                let a = bitsCachedValue & MASKS[count]
                bitsCachedValue = Int64(UInt64(bitsCachedValue & 0xffffffff) >> count)
                a
            case _ => (bitsCachedValue >> (bitsCachedSize - count)) & MASKS[count]
        }

        bitsCachedSize -= count
        return bitsOut
    }