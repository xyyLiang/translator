    func negative(): ModulusPoly {
        let negativeCoefficients = Array<Int64>(coefficients.size, {
                n => field.subtract(0, coefficients[n])
            })
        ModulusPoly(field, negativeCoefficients)
    }