    static func getRotation(sides: Array<Int64>, length: Int64): Int64 {
        var cornerBits = 0
        for (side in sides) {
            let t = ((side >> (length - 2)) << 1) + (side & 1)
            cornerBits = (cornerBits << 3) + t
        }
        cornerBits = ((cornerBits & 1) << 11) + (cornerBits >> 1)
        for (shift in 0..4) {
            if (bitCount(cornerBits ^ EXPECTED_CORNER_BITS[shift]) <= 2) {
                return shift
            }
        }
        throw NotFoundException()
    }