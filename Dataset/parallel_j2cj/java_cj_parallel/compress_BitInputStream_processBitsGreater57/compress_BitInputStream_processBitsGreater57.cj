    private func processBitsGreater57(count: Int64): Int64 {
        var overflow: Int64 = 0
        let bitsToAddCount: Int64 = count - bitsCachedSize
        let overflowBits: Int64 = 8 - bitsToAddCount
        let nextByte: Int64 = this.input.readOneByte()

        if (nextByte < 0) {
            return nextByte
        }

        match (byteOrder) {
            case Endian.Little =>
                let bitsToAdd: Int64 = nextByte & MASKS[bitsToAddCount]
                bitsCachedValue |= (bitsToAdd << bitsCachedSize)
                overflow = (nextByte >> bitsToAddCount) & MASKS[overflowBits]
            case _ =>
                bitsCachedValue <<= bitsToAddCount
                let bitsToAdd: Int64 = (nextByte >> overflowBits) & MASKS[bitsToAddCount]
                bitsCachedValue |= bitsToAdd
                overflow = nextByte & MASKS[overflowBits]
        }

        let bitsOut: Int64 = bitsCachedValue & MASKS[count]
        bitsCachedValue = overflow
        bitsCachedSize = overflowBits
        return bitsOut
    }