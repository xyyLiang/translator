    func multiply(scalar: Int64): GenericGFPoly {
        if (scalar == 0) {
            return field.zero.getOrThrow()
        }
        if (scalar == 1) {
            return this
        }
        let product = Array<Int64>(coefficients.size, {n => field.multiply(coefficients[n], scalar)})
        GenericGFPoly(field, product)
    }