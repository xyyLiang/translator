    func updateCRC(inByte: UInt8, repeat: Int64): Unit {
        var globalCrcShadow = this.globalCrc
        for (_ in 0..repeat) {
            let temp: UInt32 = (globalCrcShadow >> 24) ^ UInt32(inByte)
            globalCrcShadow = (globalCrcShadow << 8) ^ crc32Table[temp]
        }
        this.globalCrc = globalCrcShadow
    }