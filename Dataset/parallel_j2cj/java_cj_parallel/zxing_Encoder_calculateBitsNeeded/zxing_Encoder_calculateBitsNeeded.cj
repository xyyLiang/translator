    static func calculateBitsNeeded(
        mode: Mode,
        headerBits: BitArray,
        dataBits: BitArray,
        version: Version
    ): Int64 {
        headerBits.size + mode.getCharacterCountBits(version) + dataBits.size
    }