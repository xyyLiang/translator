    func buildMonomial(degree: Int64, coefficient: Int64): ModulusPoly {
        if (degree < 0) {
            throw IllegalArgumentException()
        } else if (coefficient == 0) {
            getZero()
        } else {
            let coefficients = Array<Int64>(degree + 1, item: 0)
            coefficients[0] = coefficient
            ModulusPoly(this, coefficients)
        }
    }