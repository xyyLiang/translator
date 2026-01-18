    static func generateErrorCorrection(dataCodewords: String, errorCorrectionLevel: Int64): String {
        let k = getErrorCorrectionCodewordCount(errorCorrectionLevel)
        let e = Array<Char>(k, item: Char(0))
        for (i in 0..dataCodewords.size) {
            let t1 = Int64(UInt32(dataCodewords.charAt(i)) + UInt32(e[e.size - 1])) % 929
            var t2 = 0
            var t3 = 0
            for (j in (k - 1)..0 : -1) {
                t2 = (t1 * EC_COEFFICIENTS[errorCorrectionLevel][j]) % 929
                t3 = 929 - t2
                e[j] = Char((Int64(UInt32(e[j - 1])) + t3) % 929)
            }
            t2 = (t1 * EC_COEFFICIENTS[errorCorrectionLevel][0]) % 929
            t3 = 929 - t2
            e[0] = Char(t3 % 929)
        }
        let sb = StringBuilder()
        for (j in (k - 1)..-1 : -1) {
            if (e[j] != Char(0)) {
                e[j] = Char(929 - UInt32(e[j]))
            }
            sb.append(e[j])
        }
        sb.toString()
    }