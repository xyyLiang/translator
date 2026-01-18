    public func grammar(origin: Grammar): ?Grammar {
        return (cache.get(origin.hashCode()) as Grammar).getOrThrow()
    }