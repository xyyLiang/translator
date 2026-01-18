    static func checkChecksum(leftPair: Pair, rightPair: Pair): Bool {
        let checkValue = (leftPair.checksumPortion + 16 * rightPair.checksumPortion) % 79
        var targetCheckValue = 9 * leftPair.finderPattern.value + rightPair.finderPattern.value
        if (targetCheckValue > 72) {
            targetCheckValue--
        }
        if (targetCheckValue > 8) {
            targetCheckValue--
        }
        checkValue == targetCheckValue
