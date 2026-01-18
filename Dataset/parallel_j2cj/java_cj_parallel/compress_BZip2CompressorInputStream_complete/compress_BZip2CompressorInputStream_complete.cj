    private func complete(): Bool {
        this.storedCombinedCRC = UInt32(bsGetInt(this.bin()) & 0xffffffff)
        this.currentState = EOF
        this.data = None

        if (this.storedCombinedCRC != this.computedCombinedCRC) {
            throw CompressorException("BZip2 CRC error")
        }

        // Look for the next .bz2 stream if decompressing
        // concatenated files.
        // return !decompressConcatenated || !initData(false)
        return if (decompressConcatenated) {
            !initData(false)
        } else {
            true
        }
    }