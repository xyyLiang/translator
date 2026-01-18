    public func pattern(origin: Pattern): ?Pattern {
        return (cache.get(origin.hashCode()) as Pattern).getOrThrow()
    }