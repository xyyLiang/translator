    static func getTotalBitsInLayer(layers: Int64, compact: Bool): Int64 {
        (if (compact) {
            88
        } else {
            112
        } + 16 * layers) * layers
    }