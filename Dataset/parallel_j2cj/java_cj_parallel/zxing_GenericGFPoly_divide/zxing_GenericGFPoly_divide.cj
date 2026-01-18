    func divide(other: GenericGFPoly): Array<GenericGFPoly> {
        if (!refEq(field, other.field)) {
            throw IllegalArgumentException("GenericGFPolys do not have same GenericGF field")
        }
        if (other.isZero()) {
            throw IllegalArgumentException("Divide by 0")
        }

        var quotient = field.zero.getOrThrow()
        var remainder = this

        let denominatorLeadingTerm = other.coefficient(other.degree())
        let inverseDenominatorLeadingTerm = field.inverse(denominatorLeadingTerm)

        while (remainder.degree() >= other.degree() && !remainder.isZero()) {
            let degreeDifference = remainder.degree() - other.degree()
            let scale = field.multiply(remainder.coefficient(remainder.degree()), inverseDenominatorLeadingTerm)
            let term = other.multiplyByMonomial(degreeDifference, scale)
            let iterationQuotient = field.buildMonomial(degreeDifference, scale)
            quotient = quotient.addOrSubtract(iterationQuotient)
            remainder = remainder.addOrSubtract(term)
        }

        [quotient, remainder]
    }