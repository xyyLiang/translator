    operator func -(other: ModulusPoly): ModulusPoly {
        if (!refEq(field, other.field)) {
            throw IllegalArgumentException("ModulusPolys do not have same ModulusGF field")
        }
        if (other.isZero) {
            this
        } else {
            this + other.negative()
        }
    }