    func runEuclideanAlgorithm(a: ModulusPoly, b: ModulusPoly, R: Int64): Array<ModulusPoly> {
        var rLast = a
        var r = b
        if (a.degree < b.degree) {
            rLast = b
            r = a
        }
        var tLast = field.getZero()
        var t = field.getOne()
        while (r.degree >= R / 2) {
            let rLastLast = rLast
            let tLastLast = tLast
            rLast = r
            tLast = t

            if (rLast.isZero) {
                throw ChecksumException()
            }
            r = rLastLast
            var q = field.getZero()
            let denominatorLeadingTerm = rLast.getCoefficient(rLast.degree)
            let dltInverse = field.inverse(denominatorLeadingTerm)
            while (r.degree >= rLast.degree && !r.isZero) {
                let degreeDiff = r.degree - rLast.degree
                let scale = field.multiply(r.getCoefficient(r.degree), dltInverse)
                q = q + field.buildMonomial(degreeDiff, scale)
                r = r - rLast.multiplyByMonomial(degreeDiff, scale)
            }

            t = (q * tLast - tLastLast).negative()
        }
        let sigmaTildeAtZero = t.getCoefficient(0)
        if (sigmaTildeAtZero == 0) {
            throw ChecksumException()
        }
        let inverse = field.inverse(sigmaTildeAtZero)
        let sigma = t * inverse
        let omega = r * inverse
        [sigma, omega]
    }