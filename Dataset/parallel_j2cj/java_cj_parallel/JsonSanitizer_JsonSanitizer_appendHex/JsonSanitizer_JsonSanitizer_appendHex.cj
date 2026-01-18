    private func appendHex(n: UInt32, nDigits: Int64): Unit {
        var quadsToShift = nDigits - 1
        while (quadsToShift >= 0) {
            let dig = (n >> (4 * quadsToShift)) & 0xf
            let digOrd = if (dig < 10) {
                dig + ORD_0
            } else {
                dig - 10 + ORD_a
            }
            sanitizedJson.getOrThrow().append(Char(digOrd))
            quadsToShift--
        }
    }