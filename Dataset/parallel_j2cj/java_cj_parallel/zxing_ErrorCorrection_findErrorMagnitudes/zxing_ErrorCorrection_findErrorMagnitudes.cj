    func findErrorMagnitudes(errorEvaluator: ModulusPoly, errorLocator: ModulusPoly, errorLocations: Array<Int64>): Array<Int64> {
        let errorLocatorDegree = errorLocator.degree
        if (errorLocatorDegree < 1) {
            return []
        }
        let formalDerivativeCoefficients = Array<Int64>(
            errorLocatorDegree,
            {
                n =>
                let i = n + 1
                field.multiply(i, errorLocator.getCoefficient(i))
            }
        )
        let formalDerivative = ModulusPoly(field, formalDerivativeCoefficients)
        Array<Int64>(errorLocations.size,
            {
                i =>
                let xiInverse = field.inverse(errorLocations[i])
                let numerator = field.subtract(0, errorEvaluator.evaluateAt(xiInverse))
                let denominator = field.inverse(formalDerivative.evaluateAt(xiInverse))
                field.multiply(numerator, denominator)
            })
    }