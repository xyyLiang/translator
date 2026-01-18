    private static func checkBounds(checkVal: Int64, limitExclusive: Int64, name: String): Unit {
        if (checkVal < 0) {
            throw CompressorException("Corrupted input, ${name} value negative")
        }
        if (checkVal >= limitExclusive) {
            throw CompressorException("Corrupted input, ${name} value too big")
        }
    }