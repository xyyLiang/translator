    func findErrorMagnitudes(errorEvaluator: GenericGFPoly, errorLocations: Array<Int64>): Array<Int64> {
        let s = errorLocations.size
        let result = Array<Int64>(s, item: 0)
        for (i in 0..s) {
            let xiInverse = field.inverse(errorLocations[i])
            var denominator = 1
            for (j in 0..s) {
                if (i != j) {
                    let term = field.multiply(errorLocations[j], xiInverse)
                    let termPlus1 = if ((term & 0x1) == 0) {
                        term | 1
                    } else {
                        term & (!1)
                    }
                    denominator = field.multiply(denominator, termPlus1)
                }
            }
            result[i] = field.multiply(
                errorEvaluator.evaluateAt(xiInverse),
                field.inverse(denominator)
            )
            if (field.generatorBase != 0) {
                result[i] = field.multiply(result[i], xiInverse)
            }
        }
        result
    }