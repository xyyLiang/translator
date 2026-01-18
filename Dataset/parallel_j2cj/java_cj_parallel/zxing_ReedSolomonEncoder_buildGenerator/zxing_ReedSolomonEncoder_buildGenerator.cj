    func buildGenerator(degree: Int64): GenericGFPoly {
        if (degree >= cachedGenerators.size) {
            var lastGenerator = cachedGenerators[cachedGenerators.size - 1]
            for (d in cachedGenerators.size..=degree) {
                let nextGenerator = lastGenerator.multiply(
                    GenericGFPoly(field, [1, field.exp(d - 1 + field.generatorBase)]))
                cachedGenerators.append(nextGenerator)
                lastGenerator = nextGenerator
            }
        }
        cachedGenerators[degree]
    }