    func evaluateAt(a: Int64): Int64 {
        if (a == 0) {
            coefficient(0)
        } else if (a == 1) {
            var result = 0
            for (coefficient in coefficients) {
                result = GenericGF.addOrSubtract(result, coefficient)
            }
            result
        } else {
            var result = coefficients[0]
            for (i in 1..coefficients.size) {
                result = GenericGF.addOrSubtract(field.multiply(a, result), coefficients[i])
            }
            result
        }
    }