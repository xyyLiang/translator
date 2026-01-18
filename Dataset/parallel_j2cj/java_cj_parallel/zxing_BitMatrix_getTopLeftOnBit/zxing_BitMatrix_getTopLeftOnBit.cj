    public func getTopLeftOnBit(): ?Array<Int64> {
        var bitsOffset = 0
        while (bitsOffset < this.bits.size && this.bits[bitsOffset] == 0) {
            bitsOffset++
        }
        if (bitsOffset == this.bits.size) {
            return None
        }
        let y = bitsOffset / rowSize
        var x = (bitsOffset % rowSize) * 32

        let theBits = bits[bitsOffset]
        var bit = 0
        while ((theBits << (31 - bit)) == 0) {
            bit++
        }
        x += bit
        return [x, y]
