    static func chooseVersion(numInputBits: Int64, ecLevel: ErrorCorrectionLevel): Version {
        for (versionNum in 1..=40) {
            let version = versionForNumber(versionNum)
            if (willFit(numInputBits, version, ecLevel)) {
                return version
            }
        }
        throw WriterException("Data too big")
    }