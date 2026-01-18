    operator func *(scalar: Int64): ModulusPoly {
        if (scalar == 0) {
            return field.getZero()
        }
        if (scalar == 1) {
            return this
        }
        let product = Array<Int64>(coefficients.size, {
                n => field.multiply(coefficients[n], scalar)
            })
        ModulusPoly(field, product)
    }