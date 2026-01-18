    operator func +(other: ModulusPoly): ModulusPoly {
        if (!refEq(field, other.field)) {
            throw IllegalArgumentException("ModulusPolys do not have same ModulusGF field")
        }
        if (this.isZero) {
            return other
        }
        if (other.isZero) {
            return this
        }

        let (largerCoefficients, smallerCoefficients) = if (this.coefficients.size > other.coefficients.size) {
            (this.coefficients, other.coefficients)
        } else {
            (other.coefficients, this.coefficients)
        }
        let lengthDiff = largerCoefficients.size - smallerCoefficients.size
        let sumDiff = Array<Int64>(
            largerCoefficients.size,
            {
                n => if (n < lengthDiff) {
                    largerCoefficients[n]
                } else {
                    field.add(smallerCoefficients[n - lengthDiff], largerCoefficients[n])
                }
            }
        )

        ModulusPoly(field, sumDiff)
    }