    public func sort(): ParameterList {
        let sorted: ParameterList = ParameterList(this.params)
        sorted.params.sortBy(this.compareTo)
        return sorted
    }


    private func compareTo(right: OAuth4cjParameter, left: OAuth4cjParameter): Ordering {
        let keyDiff: Ordering = right.getKey().compare(left.getKey())
        if (keyDiff != Ordering.EQ) {
            return keyDiff
        }
        return right.getValue().compare(left.getValue())
    }