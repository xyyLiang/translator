    static func willFit(numInputBits: Int64, version: Version, ecLevel: ErrorCorrectionLevel): Bool {
        let numBytes = version.totalCodewords
        let ecBlocks = version.ecBlocksForLevel(ecLevel)
        let numEcBytes = ecBlocks.totalECCodewords()
        let numDataBytes = numBytes - numEcBytes
        let totalInputBytes = (numInputBits + 7) / 8
        numDataBytes >= totalInputBytes
    }