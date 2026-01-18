    private func initData(isFirstStream: Bool): Bool {
        if (this.bin.isNone()) {
            throw CompressorException("No InputStream")
        }
        let bin = this.bin()
        if (!isFirstStream) {
            bin.clearBitCache()
        }

        let byte0: Int64 = readNextByte(bin)
        if (byte0 == -1 && !isFirstStream) {
            return false
        }
        let byte1: Int64 = readNextByte(bin)
        let byte2: Int64 = readNextByte(bin)

        // 'B'==66==0x42, 'Z'==90==0x5a, 'h'==104==0x68
        if (byte0 != 0x42 || byte1 != 0x5a || byte2 != 0x68) {
            throw CompressorException(
                if (isFirstStream) {
                    "Stream is not in the BZip2 format"
                } else {
                    "Garbage after a valid BZip2 stream"
                }
            )
        }

        let blockSize: Int64 = readNextByte(bin)
        if (blockSize < '1'.hashCode() || blockSize > '9'.hashCode()) {
            throw CompressorException("BZip2 block size is invalid")
        }

        this.blockSize100k = blockSize - '0'.hashCode()

        this.computedCombinedCRC = 0

        return true
    }