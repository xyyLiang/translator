    func updateCRC(inByte: UInt8): Unit {
        var temp: UInt32 = (globalCrc >> 24) ^ UInt32(inByte)
        globalCrc = (globalCrc << 8) ^ CRC.crc32Table[temp]
    }