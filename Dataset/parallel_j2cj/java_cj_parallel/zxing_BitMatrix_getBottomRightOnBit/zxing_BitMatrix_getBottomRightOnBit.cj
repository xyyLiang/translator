    public func getBottomRightOnBit(): ?Array<Int64> {
        var bitsOffset = this.bits.size - 1
        while (bitsOffset >= 0 && this.bits[bitsOffset] == 0) {
            bitsOffset--
        }
        if (bitsOffset < 0) {
            return None
        }

        let y = bitsOffset / rowSize
        var x = (bitsOffset % rowSize) * 32

        let theBits = bits[bitsOffset]
        var bit = 31
        while (Int64(UInt64(theBits) >> bit) == 0) {
            bit--
        }
        x += bit

        return [x, y]
    }