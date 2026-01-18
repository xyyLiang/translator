    @overflowWrapping
    public func nextUnset(fro: Int64): Int64 {
        if (fro >= size) {
            return size
        }
        var bitsOffset = fro / 32
        var currentBits = !Int32(bits[bitsOffset])

        currentBits &= -(1 << (fro & 0x1F))
        while (currentBits == 0) {
            bitsOffset++
            if (bitsOffset == this.bits.size) {
                return size
            }
            currentBits = !Int32(bits[bitsOffset])
        }
        let result = Int32(bitsOffset) * 32 + numberOfTrailingZeros(currentBits)
        Int64(math.min(result, Int32(size)))
    }
