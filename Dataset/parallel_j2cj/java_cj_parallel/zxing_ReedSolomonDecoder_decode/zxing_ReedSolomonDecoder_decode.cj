    public func decode(received: Array<Int64>, twoS: Int64) {
        let poly = GenericGFPoly(field, received)
        let syndromeCoefficients = Array<Int64>(twoS, item: 0)
        var noError = true
        for (i in 0..twoS) {
            let eval = poly.evaluateAt(field.exp(i + field.generatorBase))
            syndromeCoefficients[syndromeCoefficients.size - 1 - i] = eval
            if (eval != 0) {
                noError = false
            }
        }
        if (noError) {
            return
        }
        let syndrome = GenericGFPoly(field, syndromeCoefficients)
        let sigmaOmega = runEuclideanAlgorithm(field.buildMonomial(twoS, 1), syndrome, twoS)
        let sigma = sigmaOmega[0]
        let omega = sigmaOmega[1]
        let errorLocations = findErrorLocations(sigma)
        let errorMagnitudes = findErrorMagnitudes(omega, errorLocations)
        for (i in 0..errorLocations.size) {
            let position = received.size - 1 - field.log(errorLocations[i])
            if (position < 0) {
                throw ReedSolomonException("Bad error location")
            }
            received[position] = GenericGF.addOrSubtract(received[position], errorMagnitudes[i])
        }
    }