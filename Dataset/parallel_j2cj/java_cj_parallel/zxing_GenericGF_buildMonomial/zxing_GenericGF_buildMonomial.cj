    func buildMonomial(degree: Int64, coefficient: Int64): GenericGFPoly {
        if (degree < 0) {
            throw IllegalArgumentException()
        }
        if (coefficient == 0) {
            return zero.getOrThrow()
        }
        let coefficients = Array<Int64>(degree + 1, item: 0)
        coefficients[0] = coefficient
        GenericGFPoly(this, coefficients)
    }
