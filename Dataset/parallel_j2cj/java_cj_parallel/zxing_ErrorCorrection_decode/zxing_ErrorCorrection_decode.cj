    func decode(received: Array<Int64>, numECCodewords: Int64, erasures: ?Array<Int64>): Int64 {
        let poly = ModulusPoly(field, received)
        let S = Array<Int64>(numECCodewords, item: 0)
        var error = false
        for (i in numECCodewords..0 : -1) {
            let eval = poly.evaluateAt(field.exp(i))
            S[numECCodewords - i] = eval
            if (eval != 0) {
                error = true
            }
        }
        if (!error) {
            return 0
        }
        var knownErrors = field.getOne()
        if (let Some(es) = erasures) {
            for (erasure in es) {
                let b = field.exp(received.size - 1 - erasure)
                let term = ModulusPoly(field, [field.subtract(0, b), 1])
                knownErrors = knownErrors * term
            }
        }
        let syndrome = ModulusPoly(field, S)
        let sigmaOmega = runEuclideanAlgorithm(field.buildMonomial(numECCodewords, 1), syndrome, numECCodewords)
        let (sigma, omega) = (sigmaOmega[0], sigmaOmega[1])
        let errorLocations = findErrorLocations(sigma)
        let errorMagnitudes = findErrorMagnitudes(omega, sigma, errorLocations)
        for (i in 0..errorLocations.size) {
            let position = received.size - 1 - field.log(errorLocations[i])
            if (position < 0) {
                throw ChecksumException()
            }
            received[position] = field.subtract(received[position], errorMagnitudes[i])
        }
        errorLocations.size
    }