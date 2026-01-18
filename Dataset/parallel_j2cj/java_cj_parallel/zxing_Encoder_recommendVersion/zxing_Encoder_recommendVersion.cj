    static func recommendVersion(
        ecLevel: ErrorCorrectionLevel,
        mode: Mode,
        headerBits: BitArray,
        dataBits: BitArray
    ): Version {
        let provisionalBitsNeeded = calculateBitsNeeded(mode, headerBits, dataBits, versionForNumber(1))
        let provisionalVersion = chooseVersion(provisionalBitsNeeded, ecLevel)

        let bitsNeeded = calculateBitsNeeded(mode, headerBits, dataBits, provisionalVersion)
        chooseVersion(bitsNeeded, ecLevel)
    }