    static func getCorrectedParameterData(oparameterData: Int64, compact: Bool): Int64 {
        let (numCodewords, numDataCodewords) = if (compact) {
            (7, 2)
        } else {
            (10, 4)
        }
        var parameterData = oparameterData
        let numECCodewords = numCodewords - numDataCodewords
        let parameterWords = Array<Int64>(numCodewords, item: 0)
        for (i in (numCodewords - 1)..-1 : -1) {
            parameterWords[i] = Int64(parameterData & 0xF)
            parameterData >>= 4
        }
        try {
            let rsDecoder = ReedSolomonDecoder(GenericGF.AZTEC_PARAM)
            rsDecoder.decode(parameterWords, numECCodewords)
        } catch (e: ReedSolomonException) {
            throw NotFoundException()
        }
        var result = 0
        for (i in 0..numDataCodewords) {
            result = (result << 4) + parameterWords[i]
        }
        result
    }