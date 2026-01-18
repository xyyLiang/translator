    func evaluateAt(a: Int64): Int64 {
        if (a == 0) {
            getCoefficient(0)
        } else if (a == 1) {
            var result = 0
            for (coefficient in coefficients) {
                result = field.add(result, coefficient)
            }
            result
        } else {
            var result = coefficients[0]
            for (i in 1..coefficients.size) {
                result = field.add(field.multiply(a, result), coefficients[i])
            }
            result
        }
    }