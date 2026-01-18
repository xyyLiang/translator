    public func compareTo(parameter: OAuth4cjParameter): Ordering {
        let keyDiff: Ordering = this.key.compare(parameter.getKey())
        if (keyDiff != Ordering.EQ) {
            return keyDiff
        }
        return this.value.compare(parameter.getValue())
    }