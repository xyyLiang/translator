    func findErrorLocations(errorLocator: GenericGFPoly): Array<Int64> {
        let numErrors = errorLocator.degree()
        if (numErrors == 1) { 
            return [errorLocator.coefficient(1)]
        }
        let result = Array<Int64>(numErrors, item: 0)
        var e = 0
        var i = 1
        while (i < field.size && e < numErrors) {
            if (errorLocator.evaluateAt(i) == 0) {
                result[e] = field.inverse(i)
                e++
            }
            i++
        }
        if (e != numErrors) {
            throw ReedSolomonException("Error locator degree does not match number of roots")
        }
        result
    }