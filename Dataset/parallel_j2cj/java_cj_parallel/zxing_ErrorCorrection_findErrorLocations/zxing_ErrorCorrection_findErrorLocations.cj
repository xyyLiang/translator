    func findErrorLocations(errorLocator: ModulusPoly): Array<Int64> {
        let numErrors = errorLocator.degree
        let result = Array<Int64>(numErrors, item: 0)
        var e = 0
        for (i in 1..field.size) {
            if (e >= numErrors) {
                break
            }
            if (errorLocator.evaluateAt(i) == 0) {
                result[e] = field.inverse(i)
                e++
            }
        }
        if (e != numErrors) {
            throw ChecksumException()
        } else {
            result
        }
    }