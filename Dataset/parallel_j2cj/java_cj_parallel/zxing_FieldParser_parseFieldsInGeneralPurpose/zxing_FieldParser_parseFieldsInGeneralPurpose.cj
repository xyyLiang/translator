    static func parseFieldsInGeneralPurpose(rawInformation: String): ?String {
        if (rawInformation.isEmpty()) {
            return None
        }

        if (rawInformation.size < 2) {
            throw NotFoundException()
        }

        let twoDigitDataLength = TWO_DIGIT_DATA_LENGTH.get(rawInformation.substring(0, 2))
        if (let Some(t) = twoDigitDataLength) {
            if (t.variable) {
                return processVariableAI(2, t.length, rawInformation)
            }
            return processFixedAI(2, t.length, rawInformation)
        }

        if (rawInformation.size < 3) {
            throw NotFoundException()
        }

        let firstThreeDigits = rawInformation[0..3]
        let threeDigitDataLength = THREE_DIGIT_DATA_LENGTH.get(firstThreeDigits)
        if (let Some(t) = threeDigitDataLength) {
            if (t.variable) {
                return processVariableAI(3, t.length, rawInformation)
            }
            return processFixedAI(3, t.length, rawInformation)
        }

        if (rawInformation.size < 4) {
            throw NotFoundException()
        }

        let threeDigitPlusDigitDataLength = THREE_DIGIT_PLUS_DIGIT_DATA_LENGTH.get(firstThreeDigits)
        if (let Some(t) = threeDigitPlusDigitDataLength) {
            if (t.variable) {
                return processVariableAI(4, t.length, rawInformation)
            }
            return processFixedAI(4, t.length, rawInformation)
        }

        let firstFourDigitLength = FOUR_DIGIT_DATA_LENGTH.get(rawInformation.substring(0, 4))
        if (let Some(t) = firstFourDigitLength) {
            if (t.variable) {
                return processVariableAI(4, t.length, rawInformation)
            }
            return processFixedAI(4, t.length, rawInformation)
        }

        throw NotFoundException()
    }