    func encodeCompressedWeight(buf: StringBuilder, currentPos: Int64, weightSize: Int64) {
        let originalWeightNumeric = this.generalDecoder.extractNumericValueFromBitArray(currentPos, weightSize)
        addWeightCode(buf, originalWeightNumeric)

        let weightNumeric = checkWeight(originalWeightNumeric)

        var currentDivisor = 100000
        for (i in 0..5) {
            if (weightNumeric / currentDivisor == 0) {
                buf.append('0')
            }
            currentDivisor /= 10
        }
        buf.append(weightNumeric)
    }