    func multiply(other: GenericGFPoly): GenericGFPoly {
        if (!refEq(field, other.field)) {
            throw IllegalArgumentException("GenericGFPolys do not have same GenericGF field")
        }
        if (isZero() || other.isZero()) {
            return field.zero.getOrThrow()
        }
        let aCoefficients = this.coefficients
        let aLength = aCoefficients.size
        let bCoefficients = other.coefficients
        let bLength = bCoefficients.size
        let product = Array<Int64>(aLength + bLength - 1, item: 0)
        for (i in 0..aLength) {
            let aCoeff = aCoefficients[i]
            for (j in 0..bLength) {
                product[i + j] = GenericGF.addOrSubtract(
                    product[i + j],
                    field.multiply(aCoeff, bCoefficients[j])
                )
            }
        }
        GenericGFPoly(field, product)
    }