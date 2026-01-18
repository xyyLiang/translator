    func addOrSubtract(other: GenericGFPoly): GenericGFPoly {
        if (!refEq(field, other.field)) {
            throw IllegalArgumentException("GenericGFPolys do not have same GenericGF field")
        }
        if (isZero()) {
            return other
        }
        if (other.isZero()) {
            return this
        }
        var smallerCoefficients = this.coefficients
        var largerCoefficients = other.coefficients
        if (smallerCoefficients.size > largerCoefficients.size) {
            let temp = smallerCoefficients
            smallerCoefficients = largerCoefficients
            largerCoefficients = temp
        }
        let lengthDiff = largerCoefficients.size - smallerCoefficients.size
        let mSmallerCoefficients = smallerCoefficients
        let mLargerCoefficients = largerCoefficients
        let sumDiff = Array<Int64>(
            largerCoefficients.size,
            {
                n => if (n < lengthDiff) {
                    mLargerCoefficients[n]
                } else {
                    GenericGF.addOrSubtract(mSmallerCoefficients[n - lengthDiff], mLargerCoefficients[n])
                }
            }
        )
        GenericGFPoly(field, sumDiff)
    }