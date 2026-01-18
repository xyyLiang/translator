    static func encode(data: String, minECCPercent: Int64, userSpecifiedLayers: Int64): AztecCode {
        encode(data.toUtf8Array(), minECCPercent, userSpecifiedLayers)
    }