    public func encode(toEncode: Array<Int64>, ecBytes: Int64) {
        if (ecBytes == 0) {
            throw IllegalArgumentException("No error correction bytes")
        }
        let dataBytes = toEncode.size - ecBytes
        if (dataBytes <= 0) {
            throw IllegalArgumentException("No data bytes provided")
        }
        let generator = buildGenerator(ecBytes)
        let infoCoefficients = Array<Int64>(dataBytes, {n => toEncode[n]})
        let info = GenericGFPoly(field, infoCoefficients).multiplyByMonomial(ecBytes, 1)
        let remainder = info.divide(generator)[1]
        let coefficients = remainder.coefficients
        let numZeroCoefficients = ecBytes - coefficients.size
        for (i in 0..numZeroCoefficients) {
            toEncode[dataBytes + i] = 0
        }
        for (i in 0..coefficients.size) {
            let j = i + dataBytes + numZeroCoefficients
            if (j < toEncode.size) {
                toEncode[j] = coefficients[i]
            }
        }
    }