    public func toString(): String {
        if (isZero()) {
            return "0"
        }
        let result = StringBuilder()
        let mDegree = degree
        for (degree in mDegree()..=0 : -1) {
            var coefficient = coefficient(degree)
            if (coefficient != 0) {
                if (coefficient < 0) {
                    if (degree == mDegree()) {
                        result.append("-")
                    } else {
                        result.append(" - ")
                    }
                    coefficient = -coefficient
                } else {
                    if (result.size > 0) {
                        result.append(" + ")
                    }
                }
                if (degree == 0 || coefficient != 1) {
                    let alphaPower = field.log(coefficient)
                    if (alphaPower == 0) {
                        result.append('1')
                    } else if (alphaPower == 1) {
                        result.append('a')
                    } else {
                        result.append("a^")
                        result.append(alphaPower)
                    }
                }
                if (degree != 0) {
                    if (degree == 1) {
                        result.append('x')
                    } else {
                        result.append("x^")
                        result.append(degree)
                    }
                }
            }
        }
        result.toString()
    }