    func runEuclideanAlgorithm(a: GenericGFPoly, b: GenericGFPoly, R: Int64): Array<GenericGFPoly> {
        var rLast = a
        var r = b
        if (a.degree() < b.degree()) {
            rLast = b
            r = a
        }

        var tLast = field.zero.getOrThrow()
        var t = field.one.getOrThrow()
        while (2 * r.degree() >= R) {
            let rLastLast = rLast
            let tLastLast = tLast
            rLast = r
            tLast = t

            if (rLast.isZero()) {
                throw ReedSolomonException("r_{i-1} was zero")
            }
            r = rLastLast
            var q = field.zero.getOrThrow()
            let denominatorLeadingTerm = rLast.coefficient(rLast.degree())
            let dltInverse = field.inverse(denominatorLeadingTerm)
            while (r.degree() >= rLast.degree() && !r.isZero()) {
                let degreeDiff = r.degree() - rLast.degree()
                let scale = field.multiply(r.coefficient(r.degree()), dltInverse)
                q = q.addOrSubtract(field.buildMonomial(degreeDiff, scale))
                r = r.addOrSubtract(rLast.multiplyByMonomial(degreeDiff, scale))
            }

            t = q.multiply(tLast).addOrSubtract(tLastLast)

            if (r.degree() >= rLast.degree()) {
                throw Exception("Division algorithm failed to reduce polynomial? r: ${r}, rLast: ${rLast}")
            }
        }

        let sigmaTildeAtZero = t.coefficient(0)
        if (sigmaTildeAtZero == 0) {
            throw ReedSolomonException("sigmaTilde(0) was zero")
        }

        let inverse = field.inverse(sigmaTildeAtZero)
        [t.multiply(inverse), r.multiply(inverse)]
    }