    operator func *(other: ModulusPoly): ModulusPoly {
        if (!refEq(field, other.field)) {
            throw IllegalArgumentException("ModulusPolys do not have same ModulusGF field")
        }
        if (this.isZero || other.isZero) {
            return field.getZero()
        }
        let aCoefficients = this.coefficients
        let aLength = aCoefficients.size
        let bCoefficients = other.coefficients
        let bLength = bCoefficients.size
        let product = Array<Int64>(aLength + bLength - 1, item: 0)
        for (i in 0..aLength) {
            let aCoeff = aCoefficients[i]
            for (j in 0..bLength) {
                product[i + j] = field.add(product[i + j], field.multiply(aCoeff, bCoefficients[j]))
            }
        }
        ModulusPoly(field, product)
    }