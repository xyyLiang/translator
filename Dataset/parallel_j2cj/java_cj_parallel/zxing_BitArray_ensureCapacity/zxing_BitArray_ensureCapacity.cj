    func ensureCapacity(newSize: Int64) {
        if (newSize > this.bits.size * 32) {
            let mBits = this.bits
            let mBitsSize = mBits.size
            let mSize = Int64(math.ceil(Float64(newSize) / LOAD_FACTOR))
            this.bits = Array<Int64>((mSize + 31) / 32, {
                    n => if (n < mBitsSize) {
                        mBits[n]
                    } else {
                        0
                    }
                })
        }
    }