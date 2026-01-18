    public func reverse() {
        let newBits = Array<Int64>(this.bits.size, item: 0)
        let len = (this.size - 1) / 32
        let oldBitsLen = len + 1
        for (i in 0..oldBitsLen) {
            newBits[len - i] = reverse(this.bits[i])
        }
        if (this.size != oldBitsLen * 32) {
            let leftOffset = oldBitsLen * 32 - size
            var currentInt = Int64(UInt64(newBits[0]) >> leftOffset)
            for (i in 0..oldBitsLen) {
                let nextInt = newBits[i]
                currentInt |= nextInt << (32 - leftOffset)
                newBits[i - 1] = currentInt
                currentInt = Int64(UInt64(nextInt) >> leftOffset)
            }
            newBits[oldBitsLen - 1] = currentInt
        }
        bits = newBits
    }