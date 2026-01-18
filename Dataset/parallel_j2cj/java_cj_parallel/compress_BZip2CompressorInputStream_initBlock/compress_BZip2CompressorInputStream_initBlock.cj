    private func initBlock(): Unit {
        let bin: BitInputStream = this.bin()
        var byte0: UInt8 = 0
        var byte1: UInt8 = 0
        var byte2: UInt8 = 0
        var byte3: UInt8 = 0
        var byte4: UInt8 = 0
        var byte5: UInt8 = 0

        while (true) {
            byte0 = bsGetUByte(bin)
            byte1 = bsGetUByte(bin)
            byte2 = bsGetUByte(bin)
            byte3 = bsGetUByte(bin)
            byte4 = bsGetUByte(bin)
            byte5 = bsGetUByte(bin)

            if ((byte0 ^ byte1 ^ byte2 ^ byte3 ^ byte4 ^ byte5) != headMask1) {
                break
            }
            if (complete()) {
                return
            }
        }

        // 0x31=='1'  0x41==')' 0x59=='Y' 0x26=='&' 0x53=='S'
        if ((byte0 ^ byte1 ^ byte2 ^ byte3 ^ byte4 ^ byte5) != headMask2) {
            this.currentState = EOF
            throw CompressorException("Bad block header")
        }
        this.storedBlockCRC = UInt32(bsGetInt(bin) & 0xffffffff)
        this.blockRandomised = bsR(bin, 1) == 1

        /*
         * Allocate data here instead in constructor, so we do not allocate
         * it if the input file is empty.
         */
        if (this.data.isNone()) {
            this.data = BZip2InputStreamData(this.blockSize100k)
        }

        // currBlockNo+=1
        getAndMoveToFrontDecode()

        this.crc.initializeCRC()
        this.currentState = START_BLOCK_STATE
    }