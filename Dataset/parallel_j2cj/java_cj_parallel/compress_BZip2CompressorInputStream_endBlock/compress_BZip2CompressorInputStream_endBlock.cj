    private func endBlock(): Unit {
        this.computedBlockCRC = this.crc.getFinalCRC()

        // A bad CRC is considered a fatal error.
        if (this.storedBlockCRC != this.computedBlockCRC) {
            // make next blocks readable without error
            // (repair feature, not yet documented, not tested)
            this.computedCombinedCRC = (this.storedCombinedCRC << 1) | (this.storedCombinedCRC >> 31)
            this.computedCombinedCRC ^= this.storedBlockCRC

            throw CompressorException("BZip2 CRC error")
        }

        this.computedCombinedCRC = (this.computedCombinedCRC << 1) | (this.computedCombinedCRC >> 31)
        this.computedCombinedCRC ^= this.computedBlockCRC
    }