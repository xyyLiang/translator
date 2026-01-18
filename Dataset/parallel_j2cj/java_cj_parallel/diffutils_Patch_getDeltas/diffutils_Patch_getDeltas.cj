    public func getDeltas(): ArrayList<Delta<T>> {
        deltas.sortBy(DeltaComparator<T>.INSTANCE.deltaComparator, stable: false)
        return deltas
    }