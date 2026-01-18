    func multiplyByMonomial(degree: Int64, coefficient: Int64): GenericGFPoly {
        if (degree < 0) {
            throw IllegalArgumentException()
        }
        if (coefficient == 0) {
            return field.zero.getOrThrow()
        }
        let size = coefficients.size
        let product = Array<Int64>(
            size + degree,
            {
                n => if (n < size) {
                    field.multiply(coefficients[n], coefficient)
                } else {
                    0
                }
            }
        )
        GenericGFPoly(field, product)
    }