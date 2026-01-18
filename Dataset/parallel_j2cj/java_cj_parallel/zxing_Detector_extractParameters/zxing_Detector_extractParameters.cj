    func extractParameters(bullsEyeCorners: Array<ResultPoint>) {
        if (!isValid(bullsEyeCorners[0]) || !isValid(bullsEyeCorners[1]) || !isValid(bullsEyeCorners[2]) ||
            !isValid(bullsEyeCorners[3])) {
            throw NotFoundException()
        }
        let length = 2 * nbCenterLayers
        let sides = [
            sampleLine(bullsEyeCorners[0], bullsEyeCorners[1], length),
            sampleLine(bullsEyeCorners[1], bullsEyeCorners[2], length),
            sampleLine(bullsEyeCorners[2], bullsEyeCorners[3], length),
            sampleLine(bullsEyeCorners[3], bullsEyeCorners[0], length)
        ]
        shift = getRotation(sides, length)
        var parameterData = 0
        for (i in 0..4) {
            let side = sides[(shift + i) % 4]
            if (compact) {
                parameterData <<= 7
                parameterData += (side >> 1) & 0x7F
            } else {
                parameterData <<= 10
                parameterData += ((side >> 2) & (0x1f << 5)) + ((side >> 1) & 0x1F)
            }
        }
        let correctedData = getCorrectedParameterData(parameterData, compact)

        if (compact) {
            nbLayers = (correctedData >> 6) + 1
            nbDataBlocks = (correctedData & 0x3F) + 1
        } else {
            nbLayers = (correctedData >> 11) + 1
            nbDataBlocks = (correctedData & 0x7FF) + 1
        }
    }