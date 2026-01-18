    public func token(origin: Token): ?Token {
        return (cache.get(origin.hashCode()) as Token).getOrThrow()
    }