    func multiplyByMonomial(deg: Int64, coefficient: Int64): ModulusPoly {
        if (deg < 0) {
            throw IllegalArgumentException()
        }
        if (coefficient == 0) {
            return field.getZero()
        }
        let size = coefficients.size
        let product = Array<Int64>(
            size + deg,
            {
                n => if (n < size) {
                    field.multiply(coefficients[n], coefficient)
                } else {
                    0
                }
            }
        )
        ModulusPoly(field, product)
    }