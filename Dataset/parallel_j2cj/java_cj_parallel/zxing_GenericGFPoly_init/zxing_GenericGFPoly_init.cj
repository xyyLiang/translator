    protected init(field: GenericGF, oCoefficients: Array<Int64>) {
        if (oCoefficients.size == 0) {
            throw IllegalArgumentException()
        }
        this.field = field
        let coefficientsLength = oCoefficients.size
        if (coefficientsLength > 1 && oCoefficients[0] == 0) {
            var firstNonZero = 1
            while (firstNonZero < coefficientsLength && oCoefficients[firstNonZero] == 0) {
                firstNonZero++
            }
            if (firstNonZero == coefficientsLength) {
                this.coefficients = [0]
            } else {
                let first = firstNonZero
                this.coefficients = Array<Int64>(
                    coefficientsLength - first,
                    {n => oCoefficients[n + first]}
                )
            }
        } else {
            this.coefficients = oCoefficients
        }
    }