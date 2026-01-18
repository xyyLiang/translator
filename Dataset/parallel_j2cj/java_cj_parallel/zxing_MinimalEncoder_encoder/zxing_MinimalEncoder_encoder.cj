    static func encode(stringToEncode: String, version: ?Version, isGS1: Bool, ecLevel: ErrorCorrectionLevel): ResultList {
        return MinimalEncoder(stringToEncode, isGS1, ecLevel).encoder(version)
    }